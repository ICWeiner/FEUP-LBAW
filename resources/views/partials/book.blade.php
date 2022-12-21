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
        <a> <p> {{$review->reviewOwner->name}} </p> </a>

        <h3>Comments</h3>
        @foreach($review->comments as $comment)
            <a> <p>{{$comment->content}} </p> </a>
            <a> <p>{{$comment->rating}} </p> </a>
            <a> <p>{{$comment->usersOwner->name}} </p> </a>
        @endforeach
        <h4>Add a Comment</h4>
        @if (Auth::check())
        <textarea id="confirmationText" class="text" cols="86" rows ="20" name="commentText" form="commentForm"></textarea>
        <form method="POST" class="add_comment" id="commentForm" name="commentForm" action="{{ route('addComment') }}">
        {{ csrf_field() }}
        <label for="rating">Rating (between 1 and 5):</label>
        <input type="number" id="rating" name="rating" min="1" max="5">
        <input name="id_review" value="{{ $review->id_review }}" hidden required>
        <input type="submit" name="submitComment" value="Submit Comment">
        </form>
        @endif
    @endforeach

    <h4>Add a Review</h4>
    @if (Auth::check())
    <textarea id="confirmationText" class="text" cols="86" rows ="20" name="reviewText" form="reviewForm"></textarea>
    <form method="POST" class="add_review" id="reviewForm" name="reviewForm" action="{{ route('addReview') }}">
      {{ csrf_field() }}
      <label for="rating">Rating (between 1 and 5):</label>
      <input type="number" id="rating" name="rating" min="1" max="5">
      <input name="id_product" value="{{ $book->id_product }}" hidden required>
      <input type="submit" name="submitReview" value="Submit Review">
    </form>
    @endif

</article>
