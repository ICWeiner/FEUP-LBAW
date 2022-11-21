<article class="card" data-id="{{ $book->id_product }}">
<header>
  <h2><a href="/books/{{ $book->id_product }}">{{ $book->owner->name }}</a></h2>
</header>
<ul>  <!-- important info -->
    <li>{{ $book->owner->price }}</li>
    <li>{{ $book->edition }}</li>
    <li>{{ $book->owner->rating }}</li>
</ul>
<!--<ul>   info that should appear when inspection a single shoe
    <li>{ $book->authors->name }</li>
    <li>{ $book->publisher->name }</li>
    <li>{{ $book->owner->stock_quantity }}</li>
    <li>{{ $book->owner->year }}</li>
</ul>   -->
</article>
