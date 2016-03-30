function setCurrencyExchangeSetting(id) {
    var $setting = $('#setting_' + id);
    $('#currency_exchange_setting_value').val($setting.data().value);
    $('#currency_exchange_setting_base_currency').val($setting.data('base-currency'));
    $('#currency_exchange_setting_new_currency').val($setting.data('new-currency'));
    calculateConvertedValue();
}

function calculateConvertedValue() {
    value = $('#currency_exchange_setting_value').val();
    base_currency = $('#currency_exchange_setting_base_currency').val();
    new_currency = $('#currency_exchange_setting_new_currency').val();

    $.ajax({
        url: '/currency_exchange',
        dataType: 'json',
        data: {value: value, base_currency: base_currency, new_currency: new_currency}
    }).done(function(response) {
        $('#converted_value_holder').html(response.converted_value)
    });
}
