Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBED7ECAAD3
	for <linux-rtc@archiver.kernel.org>; Thu, 15 Sep 2022 01:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiIOB3R (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 14 Sep 2022 21:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiIOB3Q (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 14 Sep 2022 21:29:16 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027FB86C19;
        Wed, 14 Sep 2022 18:29:11 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MSfg75vb4znVDw;
        Thu, 15 Sep 2022 09:26:27 +0800 (CST)
Received: from dggpeml500010.china.huawei.com (7.185.36.155) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 15 Sep 2022 09:29:09 +0800
Received: from [10.67.111.232] (10.67.111.232) by
 dggpeml500010.china.huawei.com (7.185.36.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 15 Sep 2022 09:29:09 +0800
Message-ID: <739724e5-6b5d-0f79-72a8-87267dd85723@huawei.com>
Date:   Thu, 15 Sep 2022 09:29:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH -next] rtc: stmp3xxx: Add failure handling for
 stmp3xxx_wdt_register()
To:     Wolfram Sang <wsa@kernel.org>, <a.zummo@towertech.it>,
        <alexandre.belloni@bootlin.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@foss.st.com>, <akpm@linux-foundation.org>,
        <wim@iguana.be>, <linux-rtc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220914032159.94812-1-linyujun809@huawei.com>
 <YyJdf1AswoJNUcu0@shikoro>
From:   "linyujun (C)" <linyujun809@huawei.com>
In-Reply-To: <YyJdf1AswoJNUcu0@shikoro>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.232]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500010.china.huawei.com (7.185.36.155)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Thank you for your suggestion, I will send out the v2 version as soon as 
possible.

在 2022/9/15 7:02, Wolfram Sang 写道:
> This is correct, thanks.
