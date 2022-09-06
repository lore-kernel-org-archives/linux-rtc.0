Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B6DECAAA1
	for <linux-rtc@archiver.kernel.org>; Tue,  6 Sep 2022 15:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbiIFPeT (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 6 Sep 2022 11:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240407AbiIFPdp (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 6 Sep 2022 11:33:45 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772E9B93;
        Tue,  6 Sep 2022 07:44:22 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MMSBJ4RYmzkWSs;
        Tue,  6 Sep 2022 22:16:56 +0800 (CST)
Received: from [10.67.110.73] (10.67.110.73) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 6 Sep
 2022 22:19:29 +0800
Message-ID: <55bc9edd-f76a-c875-1b94-54f2f7fe4446@huawei.com>
Date:   Tue, 6 Sep 2022 22:19:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH -next v3] rtc: fsl-ftm-alarm: Use module_init and add
 module_exit
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>
CC:     <linux-rtc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220905062613.1119008-1-chris.zjh@huawei.com>
 <5472f57c-9805-4021-fbc7-38363aab0e88@prevas.dk>
From:   "zhangjianhua (E)" <chris.zjh@huawei.com>
In-Reply-To: <5472f57c-9805-4021-fbc7-38363aab0e88@prevas.dk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

This is a good idea, thanks.

在 2022/9/5 21:17, Rasmus Villemoes 写道:
> On 05/09/2022 08.26, Zhang Jianhua wrote:
>> fsl-ftm-alarm driver can be built out of tree, so change the
>> macro device_initcall() to module_init() for standard usage.
> "out of tree" usually refers to modules that are not part of the
> mainline kernel.
>
> "can be built as a module" is more accurate and less confusing.
>
>> fsl-ftm-alarm registers a platform driver in module_init function,
>> however there is no module_exit function to unregister it, and it will
>> occur resource leak, so add ftm_alarm_exit() function for module_exit.
> It seems that you can avoid a lot of boilerplate using the
> module_platform_driver macro. The single line
>
> module_platform_driver(ftm_rtc_driver);
>
> should/could replace the ftm_alarm_init/ftm_alarm_exit functions and the
> explicit module_init()/module_exit() lines.
>
> Rasmus
