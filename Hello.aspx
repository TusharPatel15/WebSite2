<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Hello.aspx.cs" Inherits="Hello" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script type="text/javascript">
        $(document).ready(function () {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Hello.aspx/HelloWorld",
                data: "{}",
                dataType: "json",
                success: function (data) {
                    console.log(data.d);
                }
            });
        });
    </script>

</head>
<body>
    <p>EDI Systems</p>
    <form id="form1" runat="server">
    <div>
        
    </div>
    </form>
</body>
</html>
