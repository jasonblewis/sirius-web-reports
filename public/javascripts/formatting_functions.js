 function formatdateold(data,type,row) {
     return data.substring(0,4);
 };
 
 function formatdate(data,type,row) {
     return moment(data).format('DD/MM/YYYY');
 };

 function round2dp(data,type,row){
     return parseFloat(data).toFixed(2);
 };

 function round0dp(data,type,row){
     return parseFloat(data).toFixed(0);
 };

function fromnow(data,type,row){
    return moment() < moment(data).add(22,'hours') ? 'today' : moment(data).from(moment());
    //return moment(data).fromNow();
}

function render_url(data,type,row,meta){
    var parameters = meta.settings.oInit.columns[meta.col].parameters;
    var target_url = parameters.url;
    var target_url_id_col = parameters.url_id_col;
    console.log(parameters.url);
    console.log(target_url);
    console.log(target_url_id_col);
    return '<a href="'+target_url+'/'+row[target_url_id_col]+'">'+data+'</a>';
}
