@extends('layouts.app')

@section('content')
<!--New Product Form-->
<div id="content">
    <h1>Update Book</h1>

    <form method="POST" action="{{ route('addBooks') }}" enctype="multipart/form-data">
        {{ csrf_field() }}

        <!-- For author creation -->
        <div id="author_name" class="form-group">
            <label for="author_name">Author Name: </label>
            <input id="author_name" name="author_name" type="text" required>
        </div>

        <div id="author_url" class="form-group">
            <label for="author_url">Author's URL: </label>
            <input id="author_url" name="url" type="text" required>
        </div>

        <!-- For publisher creation -->
        <div id="publisher_name" class="form-group">
            <label for="publisher_name">Publisher Name: </label>
            <input id="publisher_name" name="publisher_name" type="text" required>
        </div>

        <!-- For book and product creation -->
        <div id="book_name" class="form-group">
            <label for="book_name">Book Name: </label>
            <input id="book_name" name="name" type="text" required>
        </div>

        <div id="edition" class="form-group">
            <label for="edition-input">Edition: </label>
            <input id="edition-input" name="edition" type="number" required min="1" step="1">
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

        <button id="submission" type="submit" class="form-group">
            Update Book!
        </button>

    </form>
</div>
@endsection
