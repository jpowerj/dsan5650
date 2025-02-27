window.document.addEventListener("DOMContentLoaded", function (event) {
  var roomHtml = "<span class='sidebar-subtitle'>W 3:30-6, Walsh 498</span>";
  var termHtml = "<span class='sidebar-subtitle'>Georgetown Spring 2025</span>";
  var emailHtml = "<span class='sidebar-subtitle w-100'>Prof. Jeff Jacobs&nbsp;<a href='mailto:jj1088@georgetown.edu' target='_blank'><i class='bi bi-envelope-at ps-1 pe-1'></i></a></span>";
  var subtitleDiv = $(`<br>${roomHtml}<br>${termHtml}<br>${emailHtml}`);
    $('.sidebar-title').append(subtitleDiv);
});
