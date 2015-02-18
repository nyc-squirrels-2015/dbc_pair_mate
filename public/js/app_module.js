var app_module = function(){
    var TimeSlot = function(){
      this.start_datetime = null;
      this.end_datetime = null;
      this.agenda = null;
    }

    var redirectWindow = function(path){
      window.location.replace(path);
    }

    var openDialog = function(){
      var value = new TimeSlot();
      return value;
    }

    var getCurrentGroupId = function(){
      //hard code this for now
      //will get this as data attribute from the page
      return 1;
    }

    var addAvialability = function(){
      var timeSlotArg = openDialog();
      if(timeSlotArg!=null){
        dataOut = JSON.stringify(timeSlotArg);
        $.ajax({
            url: "/group/"+getCurrentGroupId()+"/schedule/new.json",
            data: {schedule: dataOut},
            type: "POST",
            dataType: "json",
            success: onSucess,
            error: onError
          });
      }

    }

    var onError = function(response){
      console.log(response);
      alert("Your operation HAS FAILED. Contact DBC for help.");
    }

    var onSucess = function(response){
      redirectWindow(response.path);
    }

    var getScheduleIfFromEvent = function(e){
      var target = $(e.detail.currentTarget).closest(".calendar-listing");
      return target.attr("data-id");
    }

    //TODO move this into a helper delete/accept module
    var acceptSchedule = function(e){
      var id = getScheduleIfFromEvent(e);
        $.ajax({
           url: "/group/"+getCurrentGroupId()+"/schedule/accept.json/" +id,
            type: "POST",
            dataType: "json",
            success: onSucess,
            error: onError
        });
    }

    var deleteSchedule = function(e){
       var id = getScheduleIfFromEvent(e);
        $.ajax({
           url: "/group/"+getCurrentGroupId()+"/schedule/delete.json/" +id,
            type: "POST",
            dataType: "json",
            success: onSucess,
            error: onError
        });
    }

    addEventListener("add_button_clicked", addAvialability);
    addEventListener("accept_schedule_clicked", acceptSchedule);
    addEventListener("delete_schedule_clicked", deleteSchedule);

    //no public API - event bus architecture
    return {

    }
}();
