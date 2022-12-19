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

@if (Auth::user()->user_is_admin === true)
<form method="GET" action="{{ route('updateBook') }}">
    <input id="id_product" name="id_product" value={{ $book->id_product }} required hidden/>

    <input type="submit" value="Update Book" />
    </form>

<form method="POST" action="{{ route('deleteBook') }}">
    {{ csrf_field() }}
    <input id="id_product" name="id_product" value={{ $book->id_product }} required hidden/>

    <input type="submit" value="Delete Book" />
    </form>
@endif

<h3>Some Reviews</h3>
    @foreach($book->owner->reviews as $review)
        <a> <p> {{$review->comment}} </p> </a>
        <a> <p> {{$review->rating}} </p> </a>
        <a> <p> {{$review->review_date}} </p> </a>
    @endforeach

</article>
