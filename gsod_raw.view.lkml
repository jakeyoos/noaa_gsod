explore: test_view {}
view: test_view {
  derived_table: {
    sql: SELECT * FROM `bigquery-public-data.noaa_gsod.gsod*` WHERE {{ _user_attributes ['test'] }} ;;
  }
  dimension: stn {}
}


view: gsod_raw {
  sql_table_name: `bigquery-public-data.noaa_gsod.gsod*` ;;


#########################
##Date and Station info##
#########################

  dimension_group: partition {       ###Allows BQ to only use the appropriate GSOD tables
    label: "Weather"
    type: time
    timeframes: [year]
    sql: TIMESTAMP(PARSE_DATE('%Y', REGEXP_EXTRACT(_TABLE_SUFFIX,r'\d\d\d\d'))) ;;
  }

  dimension: stn {
    hidden: yes
    type: string
    sql: ${TABLE}.stn ;;
  }

  dimension: wban {
    hidden: yes
    type: string
    sql: ${TABLE}.wban ;;
  }

  dimension: year {
    type: string
    hidden: yes
    sql: ${TABLE}.year ;;
  }

  dimension_group: weather {
    type: time
    timeframes: [date,week,month]
    sql: CAST(CONCAT(${year},'-',${mo},'-',${da}) as timestamp) ;;
  }

  dimension: primary_key {
    primary_key: yes
    hidden: yes
    sql: Concat(${weather_date},${stn},${wban}) ;;
  }

  dimension: mo {
    hidden: yes
    type: string
    sql: ${TABLE}.mo ;;
  }

  dimension: da {
    hidden: yes
    type: string
    sql: ${TABLE}.da ;;
  }

########################################
###DATA and inital Transformations###
########################################

  dimension: temp_f {
    description: "mean daily temperature"
    hidden: yes
    type: number
    sql: ${TABLE}.temp ;;
  }
  dimension: temp_c {
    description: "mean daily temperature"
    hidden: yes
    type: number
    sql: (${temp_f} - 32) *5/9 ;;
  }

  dimension: count_temp {
    description: "count of records that make up temp mean"
    type: number
    sql: ${TABLE}.count_temp ;;
  }

  dimension: dewp_f {
    description: "mean daily dewpoint"
    type: number
    sql: ${TABLE}.dewp ;;
  }

  dimension: dewp_c {
    description: "mean daily dewpoint"
    type: number
    sql: (${dewp_f} - 32) * 5/9;;
  }

  dimension: count_dewp {
    description: "count of records that make up dewp mean"
    type: number
    sql: ${TABLE}.count_dewp ;;
  }

  dimension: slp {
    description: "mean daily sealevel pressure (millibars)"
    type: number
    sql: ${TABLE}.slp ;;
  }

  dimension: count_slp {
    description: "count of records that make up slp mean"
    type: number
    sql: ${TABLE}.count_slp ;;
  }

  dimension: stp {
    description: "mean daily station pressure (millibars)"
    type: number
    sql: ${TABLE}.stp ;;
  }

  dimension: count_stp {
    description: "count of records that make up stp mean"
    type: number
    sql: ${TABLE}.count_stp ;;
  }

  dimension: visib {
    description: "mean daily vis (miles)"
    type: number
    sql: ${TABLE}.visib ;;
  }

  dimension: count_visib {
    description: "count of records that make up visib mean"
    type: number
    sql: ${TABLE}.count_visib ;;
  }

  dimension: wdsp {
    description: "mean daily windspeed (knots)"
    type: string
    sql: ${TABLE}.wdsp ;;
  }

  dimension: count_wdsp {
    description: "count of records that make up wdsp mean"
    type: string
    sql: ${TABLE}.count_wdsp ;;
  }

  dimension: mxpsd {
    description: "max daily sustained windspeed (knots)"
    type: string
    sql: ${TABLE}.mxpsd ;;
  }

  dimension: gust {
    description: "maximum daily wind gust (knots)"
    type: number
    sql: ${TABLE}.gust ;;
  }

  dimension: max_f {
    description: "maximum daily temp"
    type: number
    sql: ${TABLE}.max ;;
  }

  dimension: max_c {
    description: "maximum daily temp"
    type: number
    sql: (${max_f} - 32) *5/9 ;;
  }

  dimension: flag_max {
    description: "Blank indicates max temp was taken from the explicit max temp report and not from the 'hourly' data. * indicates max temp was  derived from the hourly data (i.e., highest hourly or synoptic-reported temperature)"
    type: string
    sql: ${TABLE}.flag_max ;;
  }

  dimension: min_f {
    description: "min daily temp"
    type: number
    sql: ${TABLE}.min ;;
  }

  dimension: min_c {
    description: "min daily temp"
    type: number
    sql: (${min_f} - 32) *5/9;;
  }

  dimension: flag_min {
    description: "Blank indicates min temp was taken from the explicit min temp report and not from the 'hourly' data. * indicates min temp was derived from the hourly data (i.e., lowest hourly or synoptic-reported temperature)"
    type: string
    sql: ${TABLE}.flag_min ;;
  }

  dimension: prcp {
    description: "total precipitation (inches) (see flag)"
    type: number
    sql: ${TABLE}.prcp ;;
  }

  dimension: flag_prcp {
    description: "https://bigquery.cloud.google.com/table/bigquery-public-data:noaa_gsod.gsod2016"
    type: string
    sql: ${TABLE}.flag_prcp ;;
  }

  dimension: sndp {
    description: "snow depth (inches and tenths)"
    type: number
    sql: ${TABLE}.sndp ;;
  }


##These yesno dimensions indicate the presence of the dimension at the station on the day

  dimension: fog {
    type: yesno
    sql: CAST(CAST(${TABLE}.fog as INT64) as BOOLEAN) ;;
  }

  dimension: rain_drizzle {
    type: yesno
    sql: CAST(CAST(${TABLE}.rain_drizzle as INT64) as BOOLEAN) ;;
  }

  dimension: snow_ice_pellets {
    type: yesno
    sql: CAST(CAST(${TABLE}.snow_ice_pellets as INT64) as BOOLEAN) ;;
  }

  dimension: hail {
    type: yesno
    sql: CAST(CAST(${TABLE}.hail as INT64) as BOOLEAN) ;;
  }

  dimension: thunder {
    type: yesno
    sql: CAST(CAST(${TABLE}.thunder as INT64) as BOOLEAN) ;;
  }

  dimension: tornado_funnel_cloud {
    type: yesno
    sql:CAST(CAST(${TABLE}.tornado_funnel_cloud as INT64) as BOOLEAN) ;;
  }

}
