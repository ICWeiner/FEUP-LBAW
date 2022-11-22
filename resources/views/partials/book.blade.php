<article class="card" data-id="{{ $book->id_product }}">
<header>
  <h2><a href="/books/{{ $book->id_product }}">{{ $book->owner->name }}</a></h2>
</header>
<ul>  <!-- important info -->
    <li> Price = {{ $book->owner->price }}</li>
    <li> edition = {{ $book->edition }}</li>
    <li> rating = {{ $book->owner->rating }}</li>
    <li> Author =  @foreach($book->authors as $category)
                <td>{{$category->name}}</td>
            @endforeach</li>
    <li> Publisher = {{ $book->publisher->name }}</li>
    <li> Year = {{ $book->owner->year }}</li>
    <li> Stock =  {{ $book->owner->stock_quantity }}</li>
</ul>

<a class="button" href="{{ url('/updateBook') }}/{{ $book->id_product }}"><span>Update Book</span></a>
</article>