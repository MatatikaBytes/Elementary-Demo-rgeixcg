{{ config(materialized='table') }}

with stream_campaign_performance_by_location as (
    select * from {{ source('googleads_source', 'stream_campaign_performance_by_location') }}
),
stream_geo_target_constant as (
    select * from "{{var('schema')}}".stream_geo_target_constant
),
campaign_performance_by_location as (
    select
        campaign__name as campaign_name
        , substring(campaign__resource_name, 11,10 ) as customer_id
        , campaign_criterion__location__geo_target_constant as campaign_criterion_location_geo_target_constant
        , sgtc.geo_target_constant__name as geo_target_constant_name
        , metrics__average_cpc as metrics_average_cpc
        , metrics__clicks as metrics_clicks
        , metrics__cost_micros as metrics_cost_micros
        , metrics__ctr as metrics_ctr
        , metrics__impressions as metrics_impressions
        , segments__date as segments_date
    from stream_campaign_performance_by_location scpbl
    left join stream_geo_target_constant sgtc on sgtc.geo_target_constant__resource_name = scpbl.campaign_criterion__location__geo_target_constant
)
select * from campaign_performance_by_location