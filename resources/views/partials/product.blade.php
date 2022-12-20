<article class="card" data-id="{{ $product->id_product }}">
  <div class="productPage">
    <div class= "productImage">
      <img src="https://cdn.shopify.com/s/files/1/0533/2089/files/placeholder-images-product-4_large.png?format=jpg&quality=90&v=1530129360">
    </div>
    <div class = "insideProductPage">
      <h2><a href="/products/{{ $product->id_product }}">{{ $product->name }}</a></h2>
      <h3><a href="/products/{{ $product->id_product }}">{{ $product->rating }} Stars</a></h2>
      <h3><a href="/products/{{ $product->id_product }}">{{ $product->price }} $</a></h2>
      <!--<a href="#" class="delete">&#10761;</a>-->
      <input type="button" value="Add to Cart" onclick="return addToCart( {{$product->id_product}} )">

    </div>
    <a><p>Curabitur finibus dui nisi, et auctor libero congue eu. Nulla facilisi. Aliquam eros nunc, hendrerit sed nibh 
      lobortis, dictum commodo nisi. Duis mattis, metus ac rutrum congue, metus nisl sagittis massa, eget laoreet odio 
      libero nec neque. Fusce fermentum ut leo tristique ultricies. Curabitur in ex a nunc interdum tempus. 
      Vestibulum vitae velit vestibulum, eleifend nulla eget, fringilla est. Praesent purus sem, convallis sit 
      amet neque ut, congue hendrerit neque. Phasellus elementum quam magna, id mattis velit auctor vitae. 
      Pellentesque faucibus ligula sed ex malesuada, nec posuere tellus varius. Interdum et malesuada fames ac 
      ante ipsum primis in faucibus. Phasellus nec cursus mauris, eu lobortis sem. 
    </p></a>
  </div>
</article>
