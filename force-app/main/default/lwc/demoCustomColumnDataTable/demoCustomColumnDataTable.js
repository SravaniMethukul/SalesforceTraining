import lightningDataTable from 'lightning/datatable';
import progressRing from './progressRing.html';

export default class DemoCustomColumnDataTable extends lightningDataTable {

    static customTypes = {
        progRing: {
            template: progressRing,
            typeAttributes: ['variant']
        }
    }
}