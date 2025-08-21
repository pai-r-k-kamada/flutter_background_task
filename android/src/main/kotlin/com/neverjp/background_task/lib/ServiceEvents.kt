package com.neverjp.background_task.lib

enum class ServiceEvents(val id: Int, val code: String){
    Monitor(0, "monitor_notifier"),
    Range(1, "range_notifier"),
    Location(2, "location_notifier")
}
