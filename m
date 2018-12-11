Return-Path: <SRS0=kYQR=OU=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434D6C07E85
	for <linux-rtc@archiver.kernel.org>; Tue, 11 Dec 2018 11:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0466720811
	for <linux-rtc@archiver.kernel.org>; Tue, 11 Dec 2018 11:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FjwK+nJe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0466720811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbeLKLKv (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:10:51 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45777 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbeLKLKv (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 11 Dec 2018 06:10:51 -0500
Received: by mail-wr1-f68.google.com with SMTP id b14so13614328wru.12
        for <linux-rtc@vger.kernel.org>; Tue, 11 Dec 2018 03:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JRnl0wYKb9mtQeSi8uRoEcL3t5SJcT9LEhgB2gahor4=;
        b=FjwK+nJe+ateSctnax+srLZHawangeLjKAC9kEI4h0FkIS0dScFbfF9gSPbTfaGhVG
         AInUIL8rDWa3QOPZTXX4/GQWH1YlvHZywk1sufeY3ssNO/8VfT5GAoIOeif14hUuSaSD
         bxD0m9pFF5DPlr1gtn5xtQKrp6GDoJUImqUrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JRnl0wYKb9mtQeSi8uRoEcL3t5SJcT9LEhgB2gahor4=;
        b=n6MoR3xtxXQjp4FRR2vL77dbP+/T1Gd1CtIN02dkP2n51rDfXknCjuMEKyCoS/wdb1
         c5ycLZKetbPfTT7z1Z38DJqzZIyTyrlr85czR9nyvAUekT2sq0jIFgYUs2Xa+Vq/lMae
         2T5W9BUam1eKhQHpEUweN8NdeRo/KOp2KJrYRrXJGB8w30LwXlCTtMDLkWmFQjcgX2YV
         2PZTxH+kkG6Ozx3DWArj99BjT15v1o02utoJRpAHDj+MsnOjHBkQeyKbF0hqHTq8Jhj+
         XGXVJLaadIZp59NVT5xE8fENI2iKBvu/x/5J3nm6iaCbnLnJDc/e5fRQ5PpU25JFL6NQ
         qPHw==
X-Gm-Message-State: AA+aEWbjaIwioJw74Aw4RKdDqM9SwDvbTmw9RmN1TOj23R+LEkneBNzk
        HjJSnAbmThZKFgIlgNH51Wb8fw==
X-Google-Smtp-Source: AFSGD/VSnE48/EA1ypBKEbvHu+10Hu0MU6j7rXIEJywOKjUObvH+OY1VqAgTDuwdrJfEShEj2E1e1g==
X-Received: by 2002:adf:e488:: with SMTP id i8mr13532799wrm.10.1544526649748;
        Tue, 11 Dec 2018 03:10:49 -0800 (PST)
Received: from [192.168.86.29] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id u204sm4732811wmu.30.2018.12.11.03.10.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 03:10:49 -0800 (PST)
Subject: Re: [PATCH v3] nvmem: check invalid number of bytes in
 nvmem_{read,write}()
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Biju Das <biju.das@bp.renesas.com>
Cc:     Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-rtc@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
References: <1544520254-4210-1-git-send-email-biju.das@bp.renesas.com>
 <9f1a2851-58ca-2971-69d5-c1322b20130c@linaro.org>
 <OSBPR01MB210338DE328981500C6992F8B8A60@OSBPR01MB2103.jpnprd01.prod.outlook.com>
 <CAMuHMdXraSz4dtBi0hzZ-w_goKiy_fObE0S-Vi6xQhSxHNnhqQ@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <43b3a03c-3739-94d2-c97d-c36999f04a9b@linaro.org>
Date:   Tue, 11 Dec 2018 11:10:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXraSz4dtBi0hzZ-w_goKiy_fObE0S-Vi6xQhSxHNnhqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org



On 11/12/18 11:06, Geert Uytterhoeven wrote:
>> I was trying with arm32 toolchain and compiler happy. Now tried with Arm64 toolchain, it provides a warning and the below typecast fixed the issue.
>> if (unlikely(check_add_overflow(bytes, (size_t)offset, &new_bytes)))
>>
>> Does typecasting to (size_t)  fixed the issue in your environment? Please let  me know.
> That's a side-effect of offset not being loff_t...
check_add_overflow will expect all the params to be of same type, so 
changing to loff_t will not help too.


> I think that should be fixed first, else you will forget about
> removing the cast later
Yes, I agree.

> ("casts are evil").
