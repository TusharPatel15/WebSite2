<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default3.aspx.cs" Inherits="Default3" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script type="text/javascript" src="minn.js"></script>
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
    };
</script>
    
<script type="text/javascript">
    $(document).on("click", "[id*=btn1]", function () {
        alert("Edi System");
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


    </script>
</head>
<body>
    <form id="form1" runat="server">
        <input id="btn1" type="button" value="showpopup"/>
        <div>
            <h2><u>Datatable:</u></h2>
            <div id="dialog">
                <asp:GridView ID="grdDatatable" runat="server" AutoGenerateColumns="true">
                </asp:GridView>
            </div>
            <h2><u>Equivalent JSON Data Array:</u></h2>
            <div runat="server" id="dvJasonData" style="width:400px;">
            </div>
        </div>
        <br />
         <input id="btn" type="button" value="showgv" onclick="javascript:callMe();"/>
              <br />
         <table id="apexpatel" ></table>
    </form>
</body>
</html>
