//==== Method to save data into database.
function saveData() {

    //==== Call validateData() Method to perform validation. This method will return 0
    //==== if validation pass else returns number of validations fails.

    var errCount = validateData();
    //==== If validation pass save the data.
    if (errCount == 0) {
        var txtFirstName = $("#txtFirstName").val();
        var txtLastName = $("#txtLastName").val();
        var txtEmail = $("#txtEmail").val();
        var txtCity = $("#txtCity").val();
        $.ajax({
            type: "POST",
            url: location.pathname + "Default.aspx/saveData",
            data: "{firstname:'" + txtFirstName + "', lastname:'" + txtLastName + "', email:'" + txtEmail + "',city:'" + txtCity + "'}",
            contentType: "application/json; charset=utf-8",
            datatype: "jsondata",
            async: "true",
            success: function (response) {
                $(".errMsg ul").remove();
                var myObject = eval('(' + response.d + ')');
                if (myObject > 0) {
                    bindData();
                    $(".errMsg").append("<ul><li>Data saved successfully</li></ul>");
                }
                else {
                    $(".errMsg").append("<ul><li>Opppps something went wrong.</li></ul>");
                }
                $(".errMsg").show("slow");
                clear();
            },
            error: function (response) {
                alert(response.status + ' ' + response.statusText);
            }
        });

        function validateData() {

            var txtFirstName = $("#txtFirstName").val();
            var txtLastName = $("#txtLastName").val();
            var txtEmail = $("#txtEmail").val();
            var txtCity = $("#txtCity").val();
            var errMsg = "";
            var errCount = 0;
            if (txtFirstName.length <= 0) {
                errCount++;
                errMsg += "<li>Please enter FirstName.</li>";
            }
            if (txtLastName.length <= 0) {
                errCount++;
                errMsg += "<li>Please enter LastName.</li>";
            }
            if (txtEmail.length <= 0) {
                errCount++;
                errMsg += "<li>Please enter Email.</li>";
            }
            if (txtCity.length <= 0) {
                errCount++;
                errMsg += "<li>Please enter City.</li>";
            }
            if (errCount > 0) {

                $(".errMsg ul").remove()
                $(".errMsg").append("<ul>" + errMsg + "</ul>");
                $(".errMsg").slideDown('slow');
            }
            return errCount;
        }
    }

    function bindData() {

        $.ajax({
            type: "POST",
            url: location.pathname + "Default.aspx/getData",
            data: "{}",
            contentType: "application/json; charset=utf-8",
            datatype: "jsondata",
            async: "true",
            success: function (response) {
                var msg = eval('(' + response.d + ')');
                if ($('#tblResult').length != 0) // remove table if it exists
                { $("#tblResult").remove(); }
                var table = "";
                for (var i = 0; i <= (msg.length - 1); i++) {
                    var row = "";
                    row += '';
                    row += '';
                    row += '';
                    row += '';

                    row += '';
                    table += row;
                }
                table += '<table class="TblSample" id="TblSample"><thead> <tr><th>FirstName</th><th>FirstName</th><th>Email</th><th>City</th><th>Actions</th></tr></thead>  <tbody><tr><td>' + msg[i].FirstName + '</td><td>' + msg[i].LastName + '</td><td>' + msg[i].Email + '</td><td>' + msg[i].City + '</td><td><img src="edit.png" title="Edit record." onclick="bindRecordToEdit(' + msg[i].Id + ')">  <img src="delete.png" onclick="deleteRecord(' + msg[i].Id + ')" title="Delete record."></td></tr></tbody></table>';
                $('#divData').html(table);
                $("#divData").slideDown("slow");

            },
            error: function (response) {
                alert(response.status + ' ' + response.statusText);
            }
        });
    }
}