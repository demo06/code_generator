import 'package:flutter/material.dart';

class DialogPage extends StatefulWidget {
  const DialogPage({super.key});

  @override
  State<StatefulWidget> createState() => _DialogPageState();
}

class _DialogPageState extends State<DialogPage> with AutomaticKeepAliveClientMixin {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = generatorDialog();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: const Color(0XFFEFF4F9),
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12, top: 0, bottom: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Dialog生成', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.only(top: 36.0),
              child: TextField(
                  controller: _controller,
                  style: const TextStyle(fontSize: 14),
                  maxLines: 20,
                  readOnly: true,
                  decoration: const InputDecoration(border: OutlineInputBorder())),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Row(
                children: [
                  const Flexible(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: SizedBox(width: double.infinity, child: Text('')),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(onPressed: _generateToFile(), child: const Text('GenerateToFile'))),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _generateToFile() {
    //todo 生成文件
    return () {};
  }

  String generatorDialog() {
    var date = DateTime.now();
    var currentDay = "${date.year}/${date.month}/${date.day}";
    return '''
package com.zgw.home.kt.ui

import android.app.Dialog
import android.content.Context
import android.view.Gravity
import android.view.LayoutInflater
import android.view.ViewGroup
import com.zgw.base.util.CommonUtil
import com.zgw.home.R
import com.zgw.home.databinding.DialogInquireBinding

/**
 * @author Wenbin
 * @version \$version\$
 * @description  Dialog弹窗
 * @date  $currentDay
 */
open class GenerateDialog(context: Context) : Dialog(context) {
    private var binding: DialogInquireBinding


    init {
        binding = DialogGenerateBinding.inflate(LayoutInflater.from(context))
        setContentView(binding.root)
        setCanceledOnTouchOutside(true)
        initData()
        addListener()
    }

    private fun initData() {
        TODO("Not yet implemented")
    }

    private fun addListener() {
        binding.apply {
            closeIv.setOnClickListener {
                dismiss()
            }
            btn1.setOnClickListener {
                listener?.onItemClickListener(\$args\$)
                dismiss()
            }
        }
    }


    fun showDialog() {
        window?.setWindowAnimations(R.style.main_menu_animStyle_bottom)
        window?.decorView?.background = null;  // 必须在setAttributes 方法之前配置。 也就是配置完才能修改width或height。
        window?.attributes?.height = ViewGroup.LayoutParams.MATCH_PARENT;
        window?.attributes?.width = ViewGroup.LayoutParams.MATCH_PARENT;
        window?.attributes?.gravity = Gravity.BOTTOM;
        window?.decorView?.setPadding(0, 0, 0, 0);
        show()
    }

    private var listener: OnItemClickListener? = null

    fun setOnItemClickListener(listener: OnItemClickListener) {
        this.listener = listener
    }

    interface OnItemClickListener {
        fun onItemClickListener(args: String)
    }

}
    ''';
  }

  @override
  bool get wantKeepAlive => true;
}
