{{ config(materialized='table') }}

with stream_campaign_performance_by_age_range_and_device as (
    select * from {{ source('googleads_source', 'stream_campaign_performance_by_age_range_and_device') }}
),
campaign_performance_by_age_range_and_device as (
    select
        ad_group__name as ad_group_name
        , substring(ad_group__resource_name, 11,10 ) as customer_id
        , ad_group_criterion__age_range__type as ad_group_criterion_age_range_type
        , age_range_view__resource_name as age_range_view_resource_name
        , campaign__advertising_channel_type as campaign_advertising_channel_type
        , campaign__name as campaign_name
        , campaign__status as campaign_status
        , metrics__average_cpc as metrics_average_cpc
        , metrics__clicks as metrics_clicks
        , metrics__cost_micros as metrics_cost_micros
        , metrics__ctr as metrics_ctr
        , metrics__impressions as metrics_impressions
        , segments__date as segments_date
        , segments__device as segments_device
    from stream_campaign_performance_by_age_range_and_device
)
select * from campaign_performance_by_age_range_and_device