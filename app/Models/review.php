<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class review extends Model
{
    #use HasFactory;

    protected $primaryKey = 'id_review';

    protected $table = 'review';

    public $timestamps = false;

    #protected $dateFormat = 'yyyy-mm-dd';

    protected $fillable = [
        'comment', 'rating', 'review_date', 'id_product', 'id_user',
    ];

    protected $casts = [
        'id_review' => 'integer',
        'comment' => 'string',
        'rating' => 'float',
        'review_date' => 'datetime:Y-m-d',
        'id_product' => 'integer',
        'id_user' => 'integer',
    ];

    public function productOwner() {
        return $this->belongsTo(product::class);
    }

    public function reviewOwner() {
        return $this->hasOne(User::class, 'id_user');
    }

    public function comments() {
        return $this->hasMany(comment::class, 'id_review');
    }

    public function flagged() {
        return $this->hasMany('App\Models\flagged');
    }
}
