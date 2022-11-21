<article class="card" data-id="{{ $book->id_product }}">
<header>
  <h2><a href="/books/{{ $book->id_product }}">{{ $book->owner->name }}</a></h2>
</header>
<ul>  <!-- important info -->
    <li> Price = {{ $book->owner->price }}</li>
    <li> edition = {{ $book->edition }}</li>
    <li> rating = {{ $book->owner->rating }}</li>
</ul>
</article>
