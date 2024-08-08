using System.Linq.Expressions;
using System.Reflection;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore.Query;

namespace RRMS.Microservices.Infrastructure.Extensions;

public static class ModelBuilderExtensions
{
    private static readonly MethodInfo SetQueryFilterMethod = typeof(ModelBuilderExtensions)
        .GetMethods(BindingFlags.Public | BindingFlags.Static)
        .Single(t => t.IsGenericMethod && t.Name == nameof(SetQueryFilter));

    public static void SetQueryFilterOnAllEntities<TEntityInterface>(this ModelBuilder builder, Expression<Func<TEntityInterface, bool>> filterExpression)
    {
        builder.Model.GetEntityTypes()
            .Where(t => t.BaseType is null)
            .Select(t => t.ClrType)
            .Where(t => typeof(TEntityInterface).IsAssignableFrom(t))
            .ToList()
            .ForEach(type => builder.SetEntityQueryFilter(type, filterExpression));
    }

    private static void SetEntityQueryFilter<TEntityInterface>(this ModelBuilder builder, Type entityType, Expression<Func<TEntityInterface, bool>> filterExpression)
    {
        SetQueryFilterMethod
            .MakeGenericMethod(entityType, typeof(TEntityInterface))
            .Invoke(null, [builder, filterExpression]);
    }

    public static void SetQueryFilter<TEntity, TEntityInterface>(this ModelBuilder builder, Expression<Func<TEntityInterface, bool>> filterExpression)
        where TEntityInterface : class
        where TEntity : class, TEntityInterface
    {
        var concreteExpression = filterExpression.Convert<TEntityInterface, TEntity>();
        builder.Entity<TEntity>().AppendQueryFilter(concreteExpression);
    }

    public static void AppendQueryFilter<T>(this EntityTypeBuilder entityTypeBuilder, Expression<Func<T, bool>> expression)
        where T : class
    {
        var parameterType = Expression.Parameter(entityTypeBuilder.Metadata.ClrType);

        var expressionFilter = ReplacingExpressionVisitor.Replace(expression.Parameters.Single(), parameterType, expression.Body);

        if (entityTypeBuilder.Metadata.GetQueryFilter() is not null)
        {
            var currentQueryFilter = entityTypeBuilder.Metadata.GetQueryFilter();
            var currentExpressionFilter = ReplacingExpressionVisitor.Replace(currentQueryFilter.Parameters.Single(), parameterType, currentQueryFilter.Body);
            expressionFilter = Expression.AndAlso(currentExpressionFilter, expressionFilter);
        }

        var lambdaExpression = Expression.Lambda(expressionFilter, parameterType);
        entityTypeBuilder.HasQueryFilter(lambdaExpression);
    }
}
