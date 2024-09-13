{{ config(materialized='table') }}

with stream_adgroupsperformance as (
    select * from {{ source('googleads_source', 'stream_adgroupsperformance') }}
),
ad_groups_performance as (
    select
        ad_group__id as ad_group_id
        , campaign__id as campaign_id
        , substring(ad_group__resource_name, 11,10 ) as customer_id
        , metrics__clicks as metrics_clicks
        , metrics__cost_micros as metrics_cost_micros
        , metrics__impressions as metrics_impressions
    from stream_adgroupsperformance
)
select * from ad_groups_performance