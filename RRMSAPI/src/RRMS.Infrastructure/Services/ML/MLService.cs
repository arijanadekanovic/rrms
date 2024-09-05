using Microsoft.EntityFrameworkCore;
using Microsoft.ML;
using Microsoft.ML.Trainers;
using RRMS.Application.Abstractions.Persistance;
using RRMS.Application.Abstractions.Services.Identity;
using RRMS.Domain.Entities;

namespace RRMS.Infrastructure.Services.Identity.AccessTokenGenerator;

public class MLService : IMLService
{
    private readonly IDatabaseContext _databaseContext;
    private readonly MLContext _mlContext;
    private ITransformer transformer;

    public MLService(
        IDatabaseContext databaseContext
        )
    {
        ArgumentNullException.ThrowIfNull(databaseContext);

        _databaseContext = databaseContext;
        _mlContext = new MLContext();
    }

    public async Task<List<Residence>> RecommendById(int residenceId)
    {
        if (transformer == null)
        {
            return [];
        }

        var allItems = await _databaseContext.Residences.Where(x => x.Id != residenceId).ToListAsync();

        var predictionResult = new List<Tuple<Residence, float>>();

        foreach (var item in allItems)
        {
            //STEP 6: Create prediction engine and predict the score for Product 63 being co-purchased with Product 3.
            //        The higher the score the higher the probability for this particular productID being co-purchased
            var predictionengine = _mlContext.Model.CreatePredictionEngine<ResidenceEntry, Copurchase_prediction>(transformer);
            var prediction = predictionengine.Predict(
                                    new ResidenceEntry()
                                    {
                                        ResidenceId = (uint)residenceId,
                                        CoPurchaseResidenceId = (uint)item.Id,
                                    });

            predictionResult.Add(new Tuple<Residence, float>(item, prediction.Score));
        }

        var finalResult = predictionResult.OrderByDescending(x => x.Item2)
            .Select(x => x.Item1)
            .Take(3)
            .ToList();

        return finalResult;
    }

    public async Task StartTraining()
    {
        var est = BuildModel();
        await Train(est);
    }

    public MatrixFactorizationTrainer BuildModel()
    {
        //STEP 1: Create MLContext to be shared across the model creation workflow objects
        MLContext mlContext = new MLContext();

        //STEP 3: Your data is already encoded so all you need to do is specify options for MatrxiFactorizationTrainer with a few extra hyperparameters
        //        LossFunction, Alpa, Lambda and a few others like K and C as shown below and call the trainer.
        MatrixFactorizationTrainer.Options options = new MatrixFactorizationTrainer.Options();
        options.MatrixColumnIndexColumnName = nameof(ResidenceEntry.ResidenceId);
        options.MatrixRowIndexColumnName = nameof(ResidenceEntry.CoPurchaseResidenceId);
        options.LabelColumnName = "Label";
        options.LossFunction = MatrixFactorizationTrainer.LossFunctionType.SquareLossOneClass;
        options.Alpha = 0.01;
        options.Lambda = 0.025;
        // For better results use the following parameters
        //options.K = 100;
        options.C = 0.00001;

        //Step 4: Call the MatrixFactorization trainer by passing options.
        var est = mlContext.Recommendation().Trainers.MatrixFactorization(options);
        return est;
    }

    public async Task Train(MatrixFactorizationTrainer est)
    {
        var tempData = await _databaseContext.Residents
            .Include(x => x.Residence)
            .Include(x => x.User)
            .ThenInclude(x => x.Residents)
            .ThenInclude(x => x.Residence)
            .ToListAsync();

        var data = new List<ResidenceEntry>();

        foreach (var x in tempData)
        {
            if (x.User.Residents.Any())
            {
                var distinctResidenceIds = x.User.Residents.Select(x => x.ResidenceId).ToList();

                distinctResidenceIds.ForEach(y =>
                {
                    var relatedItems = x.User.Residents.Where(x => x.ResidenceId != y).ToList();

                    distinctResidenceIds.ForEach(z =>
                    {
                        data.Add(new ResidenceEntry
                        {
                            ResidenceId = (uint)y,
                            CoPurchaseResidenceId = (uint)z,
                        });
                    });
                });
            }
        }

        var traindata = _mlContext.Data.LoadFromEnumerable(data);

        //STEP 5: Train the model fitting to the DataSet
        //Please add Amazon0302.txt dataset from https://snap.stanford.edu/data/amazon0302.html to Data folder if FileNotFoundException is thrown.
        transformer = est.Fit(traindata);
    }
}
