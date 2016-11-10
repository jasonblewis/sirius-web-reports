 function formatdateold(data,type,row) {
     return data.substring(0,4);
 };
 
 function formatdate(data,type,row) {
     return moment(data).format('DD/MM/YYYY');
 };

 function round2dp(data,type,row){
     return parseFloat(data).toFixed(2);
 };

function fromnow(data,type,row){
    return moment() < moment(data).add(22,'hours') ? 'today' : moment(data).from(moment());
    //return moment(data).fromNow();
}
