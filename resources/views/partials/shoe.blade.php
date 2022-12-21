<article class="card" data-id="{{ $shoe->id_product }}">
<header>
  <h2><a href="/shoes/{{ $shoe->id_product }}">{{ $shoe->name }}</a></h2>
</header>
<ul>  <!-- info about shoeColorSize missing  -->
    <li> Price = {{ $shoe->owner->price }}</li>
    <li> Name = {{ $shoe->brand_name }}</li>
    <li> Rating = {{ $shoe->owner->rating }}</li>
    <li> Type = {{ $shoe->type_name }}</li>
    <li> Year = {{ $shoe->owner->year }}</li>
    <li> Stock = {{ $shoe->owner->stock_quantity }}</li>
</ul>

@if (Auth::user()->user_is_admin === true)
<form method="GET" action="{{ route('updateShoe') }}">
    <input id="id_product" name="id_product" value={{ $shoe->id_product }} required hidden/>

    <input type="submit" value="Update Shoes" />
    </form>

<form method="POST" action="{{ route('deleteShoe') }}">
    {{ csrf_field() }}
    <input id="id_product" name="id_product" value={{ $shoe->id_product }} required hidden/>

    <input type="submit" value="Delete Shoe" />
    </form>
    @endif

    <h3>Some Reviews</h3>
    @foreach($shoe->owner->reviews as $review)
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
      <input name="id_product" value="{{ $shoe->id_product }}" hidden required>
      <input type="submit" name="submitReview" value="Submit Review">
    </form>
    @endif

</article>
