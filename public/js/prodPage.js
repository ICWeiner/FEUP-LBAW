function up(max) {
    document.getElementById("quantity").value = parseInt(document.getElementById("quantity").value) + 1;
    if (document.getElementById("quantity").value >= parseInt(max)) {
        document.getElementById("quantity").value = max;
    }
}
function down(min) {
    document.getElementById("quantity").value = parseInt(document.getElementById("quantity").value) - 1;
    if (document.getElementById("quantity").value <= parseInt(min)) {
        document.getElementById("quantity").value = min;
    }
}