@extends('layouts.app')

@section('content')
<!--New Product Form-->
<div id="content">
    <h1>Add FunkoPop</h1>

    <form method="POST" action="{{ route('addFunkoPops') }}" enctype="multipart/form-data">
        {{ csrf_field() }}
        <div id="name" class="form-group">
            <label for="name">Name: </label>
            <input id="name" name="name" type="text" required>
        </div>

        <div id="number_pop" class="form-group">
            <label for="number_pop-input">Number Pop: </label>
            <input id="number_pop-input" name="number_pop" type="number" required min="1" step="1">
        </div>

        <div id="price" class="form-group">
            <label for="price-input">Price: </label>
            <input id="price-input" name="price" type="number" required min="0.01" step="0.01">
        </div>

        <div id="stock" class="form-group">
            <label for="stock-input">Stock: </label>
            <input id="stock-input" name="stock_quantity" type="number" required min="1" step="1">
        </div>

        <div id="url" class="form-group">
            <label for="url">URL: </label>
            <input id="url" name="url" type="text" required>
        </div>

        <div id="year" class="form-group">
            <label for="year-input">Year: </label>
            <input id="year-input" name="year" type="number" required min="2000" step="1">
        </div>

        <div id="sku" class="form-group">
            <label for="sku">SKU: </label>
            <input id="sku" name="sku" type="text" required>
        </div>

        <button id="submission" type="submit" class="form-group">
            Add FunkoPop!
        </button>

    </form>
</div>
@endsection
