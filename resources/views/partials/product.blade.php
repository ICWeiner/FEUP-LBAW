<article class="card" data-id="{{ $product->id_product }}">
<header>
  <h2><a href="/products/{{ $product->id_product }}">{{ $product->name }}</a></h2>
  <a href="#" class="delete">&#10761;</a>
</header>
<ul>
</ul>
<form class="add_to_cart">
  <input type="text" name="description" placeholder="CHANGE ME">
</form>
</article>
