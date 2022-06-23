var slideIndex = 1;
showDivs(slideIndex);

function plusDivs(slideId) {
    showDivs(slideIndex += slideId);
}

function currentDiv(slideId) {
    showDivs(slideIndex = slideId);
}

function showDivs(slideId) {
    var cont;
    var slide = document.getElementsByClassName("mySlides");
    var dots = document.getElementsByClassName("demo");
    if (slideId > slide.length) { slideIndex = 1 }
    if (slideId < 1) { slideIndex = slide.length }
    for (cont = 0; cont < slide.length; cont++) {
        slide[cont].style.display = "none";
    }
    for (cont = 0; cont < dots.length; cont++) {
        dots[cont].className = dots[cont].className.replace(" w3-white", "");
    }
    slide[slideIndex - 1].style.display = "block";
    dots[slideIndex - 1].className += " w3-white";
}