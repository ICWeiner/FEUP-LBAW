@extends('layouts.app')

@section('content')

<section>
    <ul class="list-group mt-3">
        @if(!$products->isEmpty())
        <h2 style="text-align:center; font-weight:bold;">Search Results</h2>
        <div class="d-flex flex-wrap flex-row p-2 ms-2">
        @each('partials.products', $products, 'product')
        </div>
        @endif

        @if($products -> isEmpty())
            <h2 style="text-align:center; font-weight:bold;"> Sorry, we couldn't find this product!</h2> 
        @endif

    </ul>
</section>


@endsection