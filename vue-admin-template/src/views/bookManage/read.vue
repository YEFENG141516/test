<template>
  <div>
    <el-table :data="tableData" v-loading="loading" style="width: 100%">
      <el-table-column type="index" label="序号" align="center" width="70"/>
      <el-table-column prop="bookname" label="书名" align="center"  width="300"/>
      <el-table-column prop="readname" label="借阅账号" align="center"  width="300"/>
      <el-table-column prop="readtime" label="借阅时间" align="center"  width="300"/>
      <el-table-column label="归还时间"  align="center"  width="300">
        <template v-slot="{row}">
          <a v-if="row.returntime">{{ row.returntime }}</a>
          <el-tag size="mini" v-else type="danger" >
            尚未归还
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center"  >
        <template v-slot="{row}">
          <el-button type="success" v-if="!row.returntime" @click="returnbook(row)" size='mini'>归还</el-button>
        </template>
      </el-table-column>
    </el-table>
    <el-pagination
      background
      style="margin-top: 20px;text-align: center"
      :current-page="pageNum"
      :page-size="pageSize"
      :total="total"
      :pager-count="5"
      :page-sizes="[5,15,30]"
      layout="prev,pager,next,jumper,->,sizes,total"
      @current-change="getBookList"
      @size-change="handleSizeChange"
    />
  </div>
</template>

<script>

import {mapGetters} from "vuex";

export default {
  name: "read",

  data(){
    return {
      tableData: [],
      loading: false,
      pageNum: 1,
      pageSize: 5,
      total: 0,

    }
  },
  mounted() {
    this.getBookList()

  },
  methods:{
    async getBookList(pager = 1) {
      this.loading = true
      this.pageNum = pager
      const {pageNum, pageSize} = this // 发送请求时候需要带参数
      const res = await this.$API.book.reqReadBook(pageNum, pageSize)
      if (res.code === 200) {
        this.tableData = res.msg
        this.total = res.total
        this.loading = false
      }
    },
    handleSizeChange(limit){
      this.pageSize = limit
      this.getBookList()
    },
    async returnbook(row){

      this.$confirm(`你确定归还 《${row.bookname}》 吗?`, '删除', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(async() => {
        const result = await this.$API.book.returnBook(row.id)
        if (result.code === 200) {
          this.$notify({
              type: 'success',
              message: row.bookname + ' 归还成功'
            },
          )
          await this.getBookList(this.pageNum)
        }
      }).catch(() => {
        this.$notify({
          type: 'info',
          message: '已取消'
        })
      })
    }
  }
}
</script>

<style scoped>

</style>
