Return-Path: <SRS0=WBM2=OT=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC77C04EB8
	for <linux-rtc@archiver.kernel.org>; Mon, 10 Dec 2018 12:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 413AE20855
	for <linux-rtc@archiver.kernel.org>; Mon, 10 Dec 2018 12:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yj/1fJ85"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 413AE20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbeLJMzr (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 10 Dec 2018 07:55:47 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44980 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbeLJMzr (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 10 Dec 2018 07:55:47 -0500
Received: by mail-wr1-f65.google.com with SMTP id z5so10328153wrt.11
        for <linux-rtc@vger.kernel.org>; Mon, 10 Dec 2018 04:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AU4YuNX4An+8P8G8zsH7ueR/LVSQz1ZmXdvZLoguN3Q=;
        b=Yj/1fJ85xzC00OWFxahWzK/EFStHV0Ks95EKSzpxsVNFM/FY2dD30PQx+Trh8tIQzu
         OTKF8CT59irHL1u/cQe0H/SsXe64A+WGA2ocdCl75VX8Kxc0oBW2+HpfZQEQufuOTFqZ
         lWi0iBw5uDpQPUkq3/urww1oJBhPRndIjj76E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AU4YuNX4An+8P8G8zsH7ueR/LVSQz1ZmXdvZLoguN3Q=;
        b=R7pPNq6l7KWTDzs6CYAcH5bwuBBuoXK5uxojE8CCb5gsgbKvSNXSHPoIS43ZzyybtG
         PBq1ZHKgC9Y/9/f+Necu2j4OeIFgXwYfbrcqY9wPuaM8dmiMQ8CKjMhPeGK3DIEu3AHu
         9CFh5BSyq9g0wgjEQP7dnmL2EOoYI5kg6sQdB2okPEOGUb8WUdyz3q37k5TZnKbhCbqu
         ZJKzGUwyxVIOFQTpSJFpOwOpJ2jcpiVoUjuKVRsPhYaYU5FZsPGyj8QQip5M4kRijisL
         TTLczFoKlk2Oz2rhor0LHdM31YFuYccccFO4e/XfpjdcLzHGj9z7aXX/G78KiBFmsfSf
         mC/Q==
X-Gm-Message-State: AA+aEWZH15UoO7yyEkBSZUl861aOdcBPKt35jf8+fdD0phYuitMKyRka
        dNI9yYEUX6Cears2MtyHgr4ybA==
X-Google-Smtp-Source: AFSGD/WU8tb4C5YV3xceC4QbKvz/wCs2fKlJ8NchdWN4Ogs2HUjt6Fe95i4+glqrSqjC2IR97x6zng==
X-Received: by 2002:a5d:46c2:: with SMTP id g2mr10175443wrs.49.1544446545585;
        Mon, 10 Dec 2018 04:55:45 -0800 (PST)
Received: from [192.168.86.29] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id h13sm8939852wrp.61.2018.12.10.04.55.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 04:55:45 -0800 (PST)
Subject: Re: [PATCH v4 1/5] nvmem: check invalid number of bytes in
 nvmem_device_{read,write}
To:     Biju Das <biju.das@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Simon Horman <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
References: <1544182066-31528-1-git-send-email-biju.das@bp.renesas.com>
 <1544182066-31528-2-git-send-email-biju.das@bp.renesas.com>
 <3c09d148-7102-1ee5-770a-009e40de6168@linaro.org>
 <OSBPR01MB21034A6FB7EF6E877DA0F151B8A50@OSBPR01MB2103.jpnprd01.prod.outlook.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <e6643627-e6f3-5dad-9c3f-6babb8e0ce56@linaro.org>
Date:   Mon, 10 Dec 2018 12:55:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB21034A6FB7EF6E877DA0F151B8A50@OSBPR01MB2103.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org



On 10/12/18 12:45, Biju Das wrote:
>> Its better to move checks from
>> bin_attr_nvmem_read()/bin_attr_nvmem_write() into nvmem_reg_read()
>> and nvmem_reg_write(), so its easy to maintain, rather than adding them to
>> each function.
> Initially I also thought the same. But there are some RTC drivers which is using nvmem_device
> interface  is not defining "word_size"  member. That is the reason we need to add it in separate function.
> Can you please suggest how to handle the above drivers?

Word size is optional anyway, in the case where word_size is not 
specified, its considered as one byte word_size.

--srini

> 
