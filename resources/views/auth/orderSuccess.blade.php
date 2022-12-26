@extends('layouts.app')

@section('content')
<article clas="d-flex flex-row">
<div>
    <h1 class="display-5 mb-2 text-center">Payment was successecessful </h1>
    <div class="my-auto mx-auto text-center mt-3 mb-3">
        <button class="btn btn-primary text-uppercase mr-2 px-4"><a class="text-white text-decoration-none" href="/orders/{{ $id_ord }}">View Order</a></button>
    </div>
</div>
</article>
@endsection
