# indicf5-env

Runtime for [IndicF5](https://github.com/AI4Bharat/IndicF5) on a rented GPU: torch 2.5.1 (CUDA 12.4),
transformers 4.44.2, IndicF5 at a pinned commit. Contains no model weights. The model is gated on
Hugging Face, so accept its terms there and download it with your own token at run time.

Not for RTX 50-series cards, which this torch build does not support.
