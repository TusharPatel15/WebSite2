<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="Default.aspx.cs" Inherits="_Default" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head id="Head1" runat="server">
<title>Asp.net Bind Data to Datatable using JQuery or JSON</title>
<script type="text/javascript" src="minn.js"></script>
<script type="text/javascript">
    //$(document).ready(function () {
        function callMe() {
            alert("hiii");
            //ShowPopup();
            var UserDetails = {};
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Default.aspx/BindDatatable",
                data: "{}",
                dataType: "json",
                success: function (data) {
                    alert('asdfsa :: ' + data.d);
                    for (var i = 0; i < data.d.length ; i++) {
                        $("#gvDetails").append("<tr><td>" + data.d[i].ID + "</td><td>" + data.d[i].FirstName + "</td><td>" + data.d[i].LastName + "</td><td>" + data.d[i].City + "</td><td>" + data.d[i].EmailID + "</td></tr>");
                    }

                },
                error: function (result) {
                    alert("Error");
                }
            });
        };
        function ShowPopup() {
            callMe();
            $("#dialog").dialog({
                title: "GridView",
                width: 450,
               
                buttons: {
                    Ok: function () {
                        $(this).dialog('close');
                   }
                    
                },

                modal: true
            });
        }
   
</script>

 

</head>
<body>
    <b>
        EdiSystems:
    </b>
    <form id="form1" runat="server">
    <input id="btn" type="button" value="showgv" onclick="javascript: ShowPopup();"/>

    <div id="dialog" style="display: none">
    <table id="apexpatel" border="1"></table>
    <asp:GridView ID="gvDetails" runat="server" ShowHeaderWhenEmpty="true">
      </asp:GridView>
    </div>
</form>
</body>
</html>


   