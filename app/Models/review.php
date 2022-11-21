<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class review extends Model
{
    #use HasFactory;

    protected $primaryKey = 'id_review';

    protected $table = 'review';

    public $timestamps = false;

    protected $fillable = [
        'comment', 'rating', 'review_date', 'id_product', 'id_user',
    ];

    protected $hidden = [
        'url',
    ];

    protected $casts = [
        'id_review' => 'integer',
        'comment' => 'string',
        'rating' => 'float',
        'review_date' => 'datetime:d-m-Y',
        'id_product' => 'integer',
        'id_user' => 'integer',
    ];

    public function productOwner() {
        return $this->belongsTo('App\Models\Product');
    }

    public function reviewOwner() {
        return $this->belongsTo('App\Models\User');
    }

    public function comments() {
        return $this->hasMany('App\Models\comment');
    }

    public function flagged() {
        return $this->hasMany('App\Models\flagged');
    }
}
