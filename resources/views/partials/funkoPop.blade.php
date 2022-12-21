<article class="card" data-id="{{ $funkoPop->id_product }}">
<header>
  <h2><a href="/funkoPops/{{ $funkoPop->id_product }}">{{ $funkoPop->owner->name }}</a></h2>
</header>
<ul>  <!-- important info -->
    <li> Price = {{ $funkoPop->owner->price }} </li>
    <li> Year = {{ $funkoPop->owner->year }}</li>
    <li> Rating = {{ $funkoPop->owner->rating }}</li>
    <li> Stock =  {{ $funkoPop->owner->stock_quantity }}</li>
</ul>
@if (Auth::user()->user_is_admin === true)
<form method="GET" action="{{ route('updateFunkoPop') }}">
    <input id="id_product" name="id_product" value={{ $funkoPop->id_product }} required hidden/>

    <input type="submit" value="Update FunkoPop" />
    </form>

<form method="POST" action="{{ route('deleteFunkoPop') }}">
    {{ csrf_field() }}
    <input id="id_product" name="id_product" value={{ $funkoPop->id_product }} required hidden/>

    <input type="submit" value="Delete FunkoPop" />
    </form>
    @endif

    <h3>Some Reviews</h3>
    @foreach($funkoPop->owner->reviews as $review)
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
    @endforeach

    <h4>Add a Review</h4>
    @if (Auth::check())
    <textarea id="confirmationText" class="text" cols="86" rows ="20" name="reviewText" form="reviewForm"></textarea>
    <form method="POST" class="add_review" id="reviewForm" name="reviewForm" action="{{ route('addReview') }}">
      {{ csrf_field() }}
      <label for="rating">Rating (between 1 and 5):</label>
      <input type="number" id="rating" name="rating" min="1" max="5">
      <input name="id_product" value="{{ $funkoPop->id_product }}" hidden required>
      <input type="submit" name="submitReview" value="Submit Review">
    </form>
    @endif

</article>
