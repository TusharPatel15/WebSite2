<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default2.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <%--<script type="text/javascript" src="minn.js"></script>
    <script type="text/javascript" src="minn1.js"></script>
    <script type="text/javascript" src="ui.js"></script>
    <link href="style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
    //$(document).ready(function () {
    function callMe() {
       
            var UserDetails = {};
            debugger;
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Default2.aspx/BindDatatable",           
                dataType: "json",
                success: function (data) {
                    var content = JSON.parse(data.d);
                    alert('JsonData :: ' + content[0].EmpName + ' | Lenght:: ' + data.d.length);

                    for (var i = 0; i < content.length ; i++) {
                        $("#grdDatatable").append("<tr><td>" + content[i].Id + "</td><td>" + content[i].EmpName + "</td><td>" + content[i].DailyAllowance + "</td><td>" + content[i].Salary + "</td></tr>");
                    }

                },
                error: function (result) {
                    alert("Error");
                }
            });
           
    }
      function showpopup(){
          alert("Tusrvis");

            $("#dialog").dialog({
                title: "View Details",
                buttons: {
                    Ok: function () {
                        $(this).dialog('close');
                    }
                },
                modal: true
            });
            return false;

      }
    
</script>--%>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.9/jquery-ui.js" type="text/javascript"></script>
<link href="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.9/themes/start/jquery-ui.css"
    rel="stylesheet" type="text/css" />
<script type="text/javascript">
    $(document).on("click", "[id*=btn1]", function () {
       
        callMe();
       
        $("#dialog").dialog({
            title: "View Details",
            buttons: {
                Ok: function () {
                    $(this).dialog('close');
                }
            },
            modal: true
        });
        return false;
    });

    function callMe() {

        var UserDetails = {};
        //debugger;
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "Default2.aspx/BindDatatable",
            dataType: "json",
            success: function (data) {
                var content = JSON.parse(data.d);
                //alert('JsonData :: ' + content[0].EmpName + ' | Lenght:: ' + data.d.length);

                for (var i = 0; i < content.length ; i++) {
                    $("#grdDatatable").append("<tr><td>" + content[i].ID + "</td><td>" + content[i].FirstName + "</td><td>" + content[i].LastName + "</td><td>" + content[i].City + "</td><td>" + content[i].EmailID + "</td><td><a href='javascript:DeleteMe(" + content[i].ID + ")'>Delete</a> </td></tr>");
                }

            },
            error: function (result) {
                alert("Error");
            }
        });

    }
    function DeleteMe(Did)
    {
        var ans = confirm("Are you sure to delete ID:" + Did);
        //alert("tusrvis:" +Did);
        //=== If user pressed Ok then delete the record else do nothing.
        if (ans == true) {
            debugger;
            $.ajax({
                type: "POST",
                url: "Default2.aspx/DeleteRecord",
                data: "{'ID':'" + Did + "'}",
                contentType: "application/json; charset=utf-8",
                datatype: "json",
                async: "true",
                success: function (data) {
                    //=== rebind data to remove delete record from the table.
                    $("#grdDatatable").empty();
                    callMe();
                    $(".errMsg ul").remove();
                    clear();
                },
                error: function (response) {
                    alert(response.status + ' ' + response.statusText);
                }
            });
        }

    }
    function saveData() {

        //==== Call validateData() Method to perform validation. This method will return 0 
        //==== if validation pass else returns number of validations fails.

        //var errCount = validateData();
        //==== If validation pass save the data.
        //if (errCount == 0) {
        //alert("TUsrvi");
        debugger;
        //var txtId = $("#txtID").val();
        var txtfname = $("#txtFname").val();
        var txtlname = $("#txtLname").val();
        var txtcity = $("#txtCity").val();
        var txtemailid = $("#txtEmailID").val();
            $.ajax({
                type: "POST",
                url: "Default2.aspx/SaveData",
                data: "{FirstName:'" + txtfname + "',LastName:'" + txtlname + "',City:'" + txtcity + "',EmailID:'" + txtemailid + "'}",
                contentType: "application/json; charset=utf-8",
                datatype: "json",
                async: "true",
                success: function (data) {
                    $(".errMsg ul").remove();
                    $("#grdDatatable").empty();
                    //var myObject = eval('(' + data.d + ')');
                    //if (myObject > 0) {
                        callMe();
                    //    $(".errMsg").append("<ul><li>Data saved successfully</li></ul>");
                        
                    //}
                    //else {
                    //    $(".errMsg").append("<ul><li>Opppps something went wrong.</li></ul>");
                    //}
                    //$(".errMsg").show("slow");
                    clear();
                },
                error: function (response) {
                    alert(response.status + ' ' + response.statusText);
                }
            });
    }
    function clear() {
        $("#txtID").val("");
        $("#txtFname").val("");
        $("#txtLname").val("");
        $("#txtCity").val("");
        $("#txtEmailID").val("");
    }
</script>
    <%--<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script type="text/javascript">
    var rowCount = 1;
    function addMoreRows() {
        rowCount++;
        var recRow = '<p id="rowCount' + rowCount + '"><tr><td><input name="" type="text" size="17%"  maxlength="120" /></td><td><input name="" type="text"  maxlength="120" style="margin: 4px 5px 0 5px;"/></td><td><input name="" type="text" maxlength="120" style="margin: 4px 10px 0 0px;"/></td></tr> <a href="javascript:void(0);" onclick="removeRow(' + rowCount + ');">Delete</a></p>';
        jQuery('#addedRows').append(recRow);
    }

    function removeRow(removeNum) {
        jQuery('#rowCount' + removeNum).remove();
    }
</script>--%>
   
</head>
<body>
    <form id="form1" runat="server">
        <input id="btn1" type="button" value="showPopup"/>
            <h2><u>Datatable:</u></h2>
           
               <%-- <asp:GridView ID="grdDatatable" runat="server" AutoGenerateColumns="false">
                    <Columns>
                        <asp:BoundField Datafield="ID" HeaderStyle-Wrap="false" HeaderText="ID" ItemStyle-Wrap="false"  />
                         <asp:BoundField Datafield="FirstName" HeaderStyle-Wrap="false" HeaderText="FirstName" ItemStyle-Wrap="false"  />
                         <asp:BoundField Datafield="LastName" HeaderStyle-Wrap="false" HeaderText="LastName" ItemStyle-Wrap="false"  />
                         <asp:BoundField Datafield="City" HeaderStyle-Wrap="false" HeaderText="City" ItemStyle-Wrap="false"  />
                         <asp:BoundField Datafield="EmailID" HeaderStyle-Wrap="false" HeaderText="EmailID" ItemStyle-Wrap="false"  />
                                                    
                    </Columns>
                </asp:GridView>--%>

            
            <h2><u>Equivalent JSON Data Array:</u></h2>
            <div runat="server" id="dvJasonData" style="width:400px;">
            </div>
        
        <br />
         <input id="btn" type="button" value="showgv" onclick="javascript: callMe();"/>
              <br />
        <div id="dialog">
         <table  border="1">
             <tr>
                 <th>ID</th>
                 <th>FirstName</th>
                 <th>LastName</th>
                 <th>City</th>
                 <th>EmailID</th>
                 <th>Action</th>
                 
             </tr>
             <tr>
                 <td colspan="6" width="100%">
                     <table id="grdDatatable" width="100%" border="1">

                     </table>

                 </td>
             </tr>
             <tr>
               <%-- <td><input name="" id="txtID" type="text"  value="" /></td>--%>
                <td><input name="" id="txtFname" type="text"  value="" /></td>
                <td><input name="" id="txtLname" type="text"  value="" /></td>
                <td><input name="" id="txtCity" type="text"  value="" /></td>
                 <td><input name="" id="txtEmailID" type="text"  value="" /></td>
                 
                 
                 <td><span style="font:normal 12px agency, arial; color:blue; text-decoration:underline; cursor:pointer;" onclick="saveData();">Add
</span>
                     </td>
                 </tr>
         </table>
        <%--<div id="addedRows"></div>--%>
            </div>
    </form>
</body>
</html>
