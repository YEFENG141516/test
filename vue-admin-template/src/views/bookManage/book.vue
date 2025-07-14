<template>
  <div>
    <div >
      <div style="text-align: center">
        <el-select  v-model="key" style="width: 100px"  placeholder="请选择">
          <el-option  label="书名" value="bookname"></el-option>
          <el-option label="作者" value="author"></el-option>
          <el-option label="分类" value="type"></el-option>
          <el-option label="ISBN" value="isbn"></el-option>
        </el-select>
        <el-input v-model="value" autocomplete="off" style="width: 500px; margin: 20px"></el-input>
<!--        <el-autocomplete-->
<!--          v-model="state"-->
<!--          :fetch-suggestions="querySearchAsync"-->
<!--          placeholder="请输入内容"-->
<!--          @select="handleSelect"-->
<!--          style="width: 500px; margin: 20px ">-->
<!--          <template v-slot="{ item }">-->
<!--            <div>{{ item.drugName }}</div>-->
<!--          </template>-->
<!--        </el-autocomplete>-->
        <el-button type="primary" @click="onState" >搜素</el-button>
      </div>

      <el-button type="primary" v-show="usertype===1" @click="showForm" >添加书籍</el-button>
      <el-button type="primary" v-show="usertype===1" @click="uploadDialogFormVisible = true" >Excel 批量添加</el-button>
      <!--        <el-button type="primary" icon="el-icon-plus">添加</el-button>-->

      <el-dialog :title="form.id ? '修改图书':'新增图书'" width="19.4%" :visible.sync="uploadDialogFormVisible">
        <el-upload
          class="upload-demo"
          drag
          :on-success="handleAvatarSuccess"
          action="http://localhost/dev-api/api/upload"
          multiple>
          <i class="el-icon-upload"></i>
          <div class="el-upload__text">将文件拖到此处，或<em>点击上传</em></div>
          <div class="el-upload__tip" slot="tip">只能上传xlx\xlxs文件</div>
        </el-upload>
        <el-link type="success" href="http://rcq7r03jb.hb-bkt.clouddn.com/python/%E6%89%B9%E9%87%8F%E6%8F%92%E5%85%A5%E5%9B%BE%E4%B9%A6-%E6%A8%A1%E6%9D%BF.xlsx">下载Excel模板</el-link>
      </el-dialog>

    </div>
    <el-table :data="tableData" v-loading="loading" style="width: 100%">
      <el-table-column type="index" label="序号" align="center" width="70"/>
      <el-table-column  label="书名" width="100" align="center">
        <template v-slot="row">
          <img style="width: 100px;text-align: center" src="https://book.zhishikoo.com/wp-content/uploads/2022/04/10003661.jpg" alt="">
        </template>
      </el-table-column>
      <el-table-column prop="bookname" label="封面" align="center"  width="300"/>
      <el-table-column prop="author" label="作者" align="center"  />
      <el-table-column prop="type" label="分类" align="center"  width="180"/>
      <el-table-column prop="press" label="出版社" align="center"  width="180"/>
      <el-table-column prop="time" label="出版时间" align="center" width="180" />
      <el-table-column prop="isbn" label="ISBN" align="center" width="180"/>
      <el-table-column label="操作" align="center"  >
        <template v-slot="{row}">
          <el-button type="success" @click="readBook(row)"  size='mini'>借阅</el-button>
          <el-button type="primary" @click="showForm(row)" v-show="usertype===1" size='mini'>编辑</el-button>
          <el-button type="danger" @click="deleted(row)" v-show="usertype===1" size='mini'>删除</el-button>
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

    <el-dialog :title="form.id ? '修改图书':'新增图书'" :visible.sync="dialogFormVisible">
      <el-form :model="form">
        <el-form-item label="书名" :label-width="formLabelWidth">
          <el-input v-model="form.bookname" autocomplete="off" style="width: 300px;"></el-input>
        </el-form-item>
        <el-form-item label="作者" :label-width="formLabelWidth">
          <el-input v-model="form.author" autocomplete="off" style="width: 300px;"></el-input>
        </el-form-item>
        <el-form-item label="分类" :label-width="formLabelWidth">
          <el-input v-model="form.type" autocomplete="off" style="width: 300px;"></el-input>
        </el-form-item>
        <el-form-item label="出版社"   :label-width="formLabelWidth">
          <el-input v-model="form.press" autocomplete="off" style="width: 300px;"></el-input>
        </el-form-item>
        <el-form-item label="出版时间" :label-width="formLabelWidth">
          <el-date-picker  v-model="form.time" value-format="yyyy年MM月" format="" type="month"  placeholder="选择日期"/>
        </el-form-item>
        <el-form-item label="ISBN" :label-width="formLabelWidth">
          <el-input v-model="form.isbn" autocomplete="off" style="width: 300px;"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="onForm">确 定</el-button>
      </div>
    </el-dialog>
  </div>

</template>

<script>


import {mapGetters} from "vuex";

export default {
  name: "book",
  computed: {
    ...mapGetters([
      'usertype',
    ])
  },
  data() {
    return {
      tableData: [],
      dialogFormVisible: false,
      form: {
        bookname: '',
        type: '',
        isbn: '',
        author: '',
        press: '',
        time: '',
      },
      formLabelWidth: '120px',
      pageSize: 5,
      pageNum: 1,
      total: 0,
      key: 'bookname',
      value: '',
      loading: false,
      uploadDialogFormVisible: false,
      downloadExcel: ''
    }
  },
  mounted() {
    this.getBookList()
  },
  methods: {
    async getBookList(pager = 1){
      this.loading = true
      this.pageNum = pager
      const { pageNum, pageSize } = this // 发送请求时候需要带参数
      const res = await this.$API.book.reqBooks(pageNum,pageSize,this.key,this.value)
      if (res.code === 200){
        this.tableData = res.msg
        this.total = res.total
        this.loading = false
      }
    },
    showForm(row){
      this.dialogFormVisible = true
      this.form = { ...row }
    },
    async onForm(){
      const res = await this.$API.book.reqSaveAndUpdateBooks(this.form)
      if (res.code === 200){
        // 关闭表单
        this.dialogFormVisible = false
        // 消息提示
        this.$message({
          message: '修改成功!',
          type: 'success'
        });
        await this.getBookList()
      }
    },
    deleted(row){
      this.$confirm(`你确定删除 《${row.bookname}》 吗?`, '删除', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(async() => {
        const result = await this.$API.book.delBooks(row.id)
        if (result.code === 200) {
          this.$notify({
              type: 'success',
              message: '删除成功!'
            },
            await this.getBookList()
          )
        } else {
          this.$notify({
            type: 'warning',
            message: '删除失败,请联系系统运维!'
          })
        }
      }).catch(() => {
        this.$notify({
          type: 'info',
          message: '已取消删除'
        })
      })
    },
    onState(){
      this.getBookList()
    },
    handleSizeChange(limit){
      this.pageSize = limit
      this.getUserList()
    },
    async readBook(row){

      const data = {
        'bookid': row.id,
        'bookname': row.bookname
      }
      this.$confirm(`你确定借阅 《${row.bookname}》 吗?`, '删除', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(async() => {
        const result = await this.$API.book.readBook(data)
        if (result.code === 200) {
          this.$notify({
              type: 'success',
              message: '《' + row.bookname + '》 借阅成功！请到借阅管理中查看'
            },
          )
        }
      }).catch(() => {
        this.$notify({
          type: 'info',
          message: '已取消'
        })
      })
    },
    handleAvatarSuccess(response,file, fileList){
      this.$notify({
          type: 'success',
          message: '批量添加成功!'
        },
        this.getBookList(1)
      )
    }
  }
}
</script>

<style scoped>

</style>
