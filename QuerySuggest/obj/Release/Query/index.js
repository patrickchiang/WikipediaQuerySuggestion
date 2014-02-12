$(function () {
    $("#searchbar").on("input", loadSuggestions);
});

function loadSuggestions() {
    var data = $("#searchbar").val();

    $.ajax({
        url: "http://info344qs.cloudapp.net/queries.asmx/query?data=" + data
    }).done(function (html) {
        displayResults(html);
    });
}

function displayResults(json) {
    $("#results").empty();
    if (json != "Term not found.") {
        var items = JSON.parse(json);
        for (var i = 0; i < json.length; i++) {
            var result = $("<a></a>").html(items[i]);
            result.attr("href", "http://en.wikipedia.org/wiki/" + items[i]);
            var p = $("<p></p>").append(result);
            $("#results").append(p);
        }
    } else {
        var result = $("<p></p>").html("Term not found.");
        $("#results").append(result);
    }
}