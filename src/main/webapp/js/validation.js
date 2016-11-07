
function validateForm()
{
	var checkboxError = true;
	var fileuploadError = true;
	var thinkBackError = false;
	var customFileUploadError = false;
	var species = document.getElementById("species");
	var speciesIndex = species.selectedIndex;
	var humanSelected = false;
	if (speciesIndex >= 0) 
	{
		humanSelected = (species.options[speciesIndex].value == "hsa");
	}
	
	var optionValue = getCheckedValue(document.getElementsByName("thinkBackOption"));
	optionValue = "LRPath.only";
	var thinkBackSelected = !(optionValue == "LRPath.only");
	var keggSelected = false;
	var otherSelected = false;
	
	var fup = document.getElementById('uploadfile');
	var fileName = fup.value;
	var ext = fileName.substring(fileName.lastIndexOf('.') + 1);
	if(ext == "txt")
	{
		fileuploadError = false;
	} 
	  
	for(var i=0; i < document.upform.database.length; i++)
	{
		
		if(document.upform.database[i].checked)
		{
			checkboxError = false;
		}
		if (document.upform.database[i].value == "KEGG")
		{
			keggSelected = document.upform.database[i].checked;
		}
		
		else
		{
			if (document.upform.database[i].checked)
			{
				otherSelected = true;
			}
		}
	}
	//alert(customFileUploadError);
	if(document.getElementById("custom").checked)
		{
	
		var fup1 = document.getElementById('uploadCustomfile');
		var fileName1 = fup1.value;
		alert(fileName1.length);
			if(fileName1.replace(/\s/g,"") == "" || fileName1.length < 1)
			{
				alert(fileName1);
				customFileUploadError = true;
				
			}
			
			alert(customFileUploadError);
		}
	//alert("last fileuploaderror");
	//alert(customFileUploadError);

	thinkBackError = thinkBackSelected && !(humanSelected && keggSelected && (!otherSelected) );
	
	if(checkboxError)
	{
		alert("Please select a database");
	}
	else if(fileuploadError)
	{
		alert("Please upload a valid text file");
	}
	else if(thinkBackError)
	{
		alert("When using either of the ThinkBack options you must use Human data and only the KEGG database");
	}
	else if(customFileUploadError)
	{
		alert("Please upload custom file or uncheck the custom database option");
	}
	else
	{
		loadOnSubmit();
	}
		
}

function getCheckedValue(radioObj) {
	if(!radioObj)
		return "";
	var radioLength = radioObj.length;
	if(radioLength == undefined)
		if(radioObj.checked)
			return radioObj.value;
		else
			return "";
	for(var i = 0; i < radioLength; i++) {
		if(radioObj[i].checked) {
			return radioObj[i].value;
		}
	}
	return "";
}


function loadOnSubmit()
{
	document.getElementById("formContentPanel").style.display = "none";
	document.getElementById("clusteringPanel").style.display = "none";
	document.getElementById("loadingPanel").style.display = "block";
	document.upform.submit();
	//ajaxFunction();
}


function mypopwin() 
{
	window.open( "resultHelp.jsp", "myWindow", "status = 1, height = 420, width = 560, resizable = 1" );

}

function myfisherwin() 
{
	window.open( "fisherTestHelp.jsp", "myWindow", "status = 1, height = 420, width = 560, resizable = 1" );

}

function ajaxFunction()
{
	var ajaxRequest; 
	
	try
	{
		ajaxRequest = new XMLHttpRequest();
	} 
	catch (e)
	{
		try
		{
			ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) 
		{
			try
			{
				ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
			} 
			catch (e)
			{
				alert("Your browser broke!");
				return false;
			}
		}
	}

	ajaxRequest.onreadystatechange = function()
	{
		if(ajaxRequest.readyState == 4)
		{
			alert(ajaxRequest.responseText);
		}
	};
	ajaxRequest.open("POST", "verify.jsp", true);
	ajaxRequest.setRequestHeader("Content-Type","application/x-www-form-urlencoded;");
	ajaxRequest.send("genes=Dunn");
}


var count = 3;

function addRow() 
{
	var table = document.getElementById("dataTable");
    var rowCount = table.rows.length;
    var row = table.insertRow(rowCount);

	var cell1 = row.insertCell(0);
    var cell1Html = '<span class="formText">URL</span><input id="cluster'+ count +'" type="text" name="clusterURL" class="formObject" size="40">';
    cell1.innerHTML = cell1Html;

    var cell2 = row.insertCell(1);	    
    var cell2Html = '<span class="formText">Comparison Name</span><input type="text" name="fileNames" class="formObject" size="20">'; 
    cell2.innerHTML = cell2Html;
    
    

    var cell3 = row.insertCell(2);	    
    var cell3Html = '<img src="images/delete.png" onclick="removeItem('+ count +')">'; 
    cell3.innerHTML = cell3Html;
    

    
    count++;
}

function removeItem(formId)
{
	var id = "cluster" + formId;

	try 
	{
        var table = document.getElementById("dataTable");
        var rowCount = table.rows.length;
        
        for(var i=0; i<rowCount; i++) 
        {
        	var row = table.rows[i];  	
            var itemId = row.cells[0].childNodes[1];
            
            if(itemId.id == id ) 
            {
                    table.deleteRow(i);
                    rowCount--;
                    i--;
            }
 
        }
    }
    catch(e) 
    {
       alert(e);
    }
}
	
function validate(elem){
	console.log("in validation");
    var alphaExp = /^[a-zA-Z0-9_-]+$/;
    if(elem.value.match(alphaExp)){
        return true;
    }else{
        alert("Special Characters and Spaces are not allowed for Analysis Name");
        elem.focus();
        return false;
    }
}

