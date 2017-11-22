include: "gsod_raw.view.lkml"
view: gsod {
  extends: [gsod_raw]

###Meausres for GSOD Data####
###Measures are filtered because missing values are coded as 9999.9

  parameter: time_granularity {
    type: string
    allowed_value: {label: "Week" value: "week"}
    allowed_value: {label: "Month" value: "month"}

  }
  dimension: granularity {
    type: string
    sql: CASE WHEN {% parameter time_granularity %} = 'week' THEN ${weather_week}
              WHEN {% parameter time_granularity %} = 'month' THEN ${weather_month}
              END;;

    }
  parameter: unit {
    type: string
    allowed_value: {label: "Celsius" value: "C"}
    allowed_value: {label: "Fahrenheit" value: "F"}
  }


  measure: average_temp {
    type: number
    value_format_name: temp_1
    sql: CASE WHEN {% parameter unit %} = "F" THEN ${average_temp_f}
          WHEN {% parameter unit %} = "C" THEN ${average_temp_c}
          ELSE NULL END ;;
    html: {% if _filters['gsod.unit'] == "F" %}
              {{rendered_value}}F
          {% elsif _filters['gsod.unit'] == "C" %}
              {{rendered_value}}C
          {% endif %};;
  }

#   measure: average_temp2 {
#     type: number
#     sql: {% if {% parameter unit %} == "F" %} {{ value }}
#           {% else %} That
#           {% endif %} ;;
#   }

  measure: average_temp_f {
#     hidden: yes
    group_label: "Temperature Measures"
    description: "Average of the daily mean temperature"
    type: average
    sql: ${temp_f} ;;
    value_format: "0.0\"°\""
    drill_fields: [detail*]
    filters: {
      field: temp_f
      value: "<1000"
    }
  }
    measure: average_temp_c {
    group_label: "Temperature Measures (C)"
    description: "Average of the daily mean temperature"
#     hidden: yes
    type: average
    sql: ${temp_c} ;;
      value_format: "0.0\"°C\""
    drill_fields: [detail*]
    filters: {
      field: temp_c
      value: "<1000"
    }
  }

  measure: average_dewpoint_f {
    group_label: "Temperature Measures (F)"
    description: "Average of the daily mean dewpoint"
    type: average
    sql: ${dewp_f} ;;
    value_format_name: temp_1
    drill_fields: [detail*]
    filters: {
      field: dewp_f
      value: "<1000"
    }
  }

  measure: average_maximum_temp_f {
    group_label: "Temperature Measures (F)"
    description: "Average of the daily max temperature"
    type: average
    sql: ${max_f} ;;
    value_format_name: temp_1
    drill_fields: [detail*]
    filters: {
      field: max_f
      value: "<1000"
    }
  }

  measure: max_maximum_temp_f {
    group_label: "Temperature Measures (F)"
    description: "Maximum of the daily max temperature"
    type: max
    sql: ${max_f} ;;
    value_format_name: temp_1
    drill_fields: [detail*]
    filters: {
      field: max_f
      value: "<1000"
    }
  }


  measure: average_minimum_temp_f {
    group_label: "Temperature Measures (F)"
    description: "Average of the daily min temperature"
    type: average
    sql: ${min_f} ;;
    value_format_name: temp_1
    drill_fields: [detail*]
    filters: {
      field: min_f
      value: "<1000"
    }
  }

  measure: min_minimum_temp_f {
    group_label: "Temperature Measures (F)"
    description: "Minimum of the daily min temperature"
    type: min
    sql: ${min_f} ;;
    value_format_name: temp_1
    drill_fields: [detail*]
    filters: {
      field: min_f
      value: "<1000"
    }
  }

  measure: average_sea_level_pressure {
    description: "Average sea level pressure at station (millibar)"
    type: average
    sql: ${slp} ;;
    value_format_name: decimal_1
    drill_fields: [detail*]
    filters: {
      field: slp
      value: "<9000"
    }
  }

  measure: average_station_pressure {
    description: "Average pressure at station (millibar)"
    type: average
    sql: ${stp} ;;
    value_format_name: decimal_1
    drill_fields: [detail*]
    filters: {
      field: stp
      value: "<9000"
    }
  }

  measure: total_precipitation {
    description: "Sum of the daily total precipitation (inches)"
    type: sum
    sql: ${prcp} ;;
    value_format_name: decimal_1
    drill_fields: [detail*]
    filters: {
      field: prcp
      value: "<90"
    }
  }

  measure: avg_precipitation {
    description: "Avg of the daily total precipitation (inches)"
    type: average
    sql: ${prcp} ;;
    value_format_name: decimal_1
    drill_fields: [detail*]
    filters: {
      field: prcp
      value: "<90"
    }
  }
  measure: total_snow_depth {
    description: "Sum of the daily total snow depth (inches)"
    type: sum
    sql: ${sndp} ;;
    value_format_name: decimal_1
    filters: {
      field: sndp
      value: "<900"
    }
  }

  measure: avg_snow_depth {
    description: "Avg of the daily total snow depth (inches)"
    type: average
    sql: ${sndp} ;;
    value_format_name: decimal_1
    drill_fields: [detail*]
    filters: {
      field: sndp
      value: "<900"
    }
  }

  measure: avg_windspeed_kts {
    description: "Avg of the daily mean windspeed (kts)"
    type: average
    sql: ${wdsp} ;;
    value_format_name: decimal_1
    drill_fields: [detail*]
    filters: {
      field: wdsp
      value: "<900"
    }
  }




##TEMP stuff In Celsius

#   measure: average_temp_c {
#     group_label: "Temperature Measures (C)"
#     description: "Average of the daily mean temperature"
#     type: average
#     sql: ${temp_c} ;;
#     value_format_name: temp_1
#     drill_fields: [detail*]
#     filters: {
#       field: temp_c
#       value: "<1000"
#     }
#   }
#
#   measure: average_dewpoint_c {
#     group_label: "Temperature Measures (C)"
#     description: "Average of the daily mean dewpoint"
#     type: average
#     sql: ${dewp_c} ;;
#     value_format_name: temp_1
#     drill_fields: [detail*]
#     filters: {
#       field: dewp_c
#       value: "<1000"
#     }
#   }
#
#   measure: average_maximum_temp_c {
#     group_label: "Temperature Measures (C)"
#     description: "Average of the daily max temperature"
#     type: average
#     sql: ${max_c} ;;
#     value_format_name: temp_1
#     drill_fields: [detail*]
#     filters: {
#       field: max_c
#       value: "<1000"
#     }
#   }
#
#   measure: min_minimum_temp_c {
#     group_label: "Temperature Measures (C)"
#     description: "Minimum of the daily min temperature"
#     type: min
#     sql: ${min_c} ;;
#     value_format_name: temp_1
#     drill_fields: [detail*]
#     filters: {
#       field: min_c
#       value: "<1000"
#     }
#   }
#
#   measure: average_minimum_temp_c {
#     group_label: "Temperature Measures (C)"
#     description: "Average of the daily min temperature"
#     type: average
#     sql: ${min_c} ;;
#     value_format_name: temp_1
#     drill_fields: [detail*]
#     filters: {
#       field: min_c
#       value: "<1000"
#     }
#   }

  set: detail {
    fields: [stations.name, stations.country, average_temp_f]
  }

}
