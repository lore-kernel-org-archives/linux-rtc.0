Return-Path: <SRS0=kYQR=OU=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D304C07E85
	for <linux-rtc@archiver.kernel.org>; Tue, 11 Dec 2018 09:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E76152082F
	for <linux-rtc@archiver.kernel.org>; Tue, 11 Dec 2018 09:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="flWk/xtd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E76152082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbeLKJzq (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:55:46 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35015 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbeLKJzq (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 11 Dec 2018 04:55:46 -0500
Received: by mail-wr1-f67.google.com with SMTP id 96so13393904wrb.2
        for <linux-rtc@vger.kernel.org>; Tue, 11 Dec 2018 01:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ma+3LrckplbHCMdn+o7ywGisiWmlS7CTJKqJkXNdMog=;
        b=flWk/xtdby+3CEFX5xxW/elbG5GPHecO5KdSzKchuZ6OlguEnJKRnbWfcRG/L5tq35
         HHR2pjAzJs0z0eCHsa4F0VK1r0EHq/LMjv1SfHuf5iB6yN40W/mx6AvmCkKyHN44aRM9
         TKp4ilUtBMj5t26G49SNwYV5g37m/AqXBGI0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ma+3LrckplbHCMdn+o7ywGisiWmlS7CTJKqJkXNdMog=;
        b=UTaSjauV1yxvxE+E3EMbfa2zbLJeDzC8ty7KwZF9f1ACZgT2mfT+xf9o1R+hKZWxzd
         ZBavZjgyHPzRvb8ZQhVMnf+/JBimFL8DIGMgHGsZBbYrto14HCXb1HUuRbastxUXhtJ9
         vPYYjwtABws04XdAvXd4HbO/avHKZNK9KD3gqDur4x8py7xL+YwBFpj9K9+N7Z5hwLy0
         8Xs6/1DMx1FV8BzYUJrk/tQXWZU7lC1Q4xuxB616taaVOLIe52dlqIVu6sjzuqBE1cHv
         Zs3wN1ESzZfqxyejLD/dgMYcdqrQToFrV65KhwL390Haln2xGXyE54+xdc5dGUVM32qh
         1V+g==
X-Gm-Message-State: AA+aEWY1eGtlQZDiU3wogxz2uXXJUoMpubnxx9ATwqYJIcprmNrtkxvI
        UySnzLtm1znG19KIbaIk3tCHaQ==
X-Google-Smtp-Source: AFSGD/VDSJntlDob4nN3baG1IoYZfmaYuVSDrIcUj2m40i3OGzKUK2r+YiVrliYou+3Blm2HVHRA1w==
X-Received: by 2002:a5d:6907:: with SMTP id t7mr12505249wru.226.1544522145099;
        Tue, 11 Dec 2018 01:55:45 -0800 (PST)
Received: from [192.168.86.29] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id c10sm15325279wrw.49.2018.12.11.01.55.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 01:55:44 -0800 (PST)
Subject: Re: [PATCH v3] nvmem: check invalid number of bytes in
 nvmem_{read,write}()
To:     Biju Das <biju.das@bp.renesas.com>
Cc:     Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-rtc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <1544520254-4210-1-git-send-email-biju.das@bp.renesas.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <9f1a2851-58ca-2971-69d5-c1322b20130c@linaro.org>
Date:   Tue, 11 Dec 2018 09:55:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1544520254-4210-1-git-send-email-biju.das@bp.renesas.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org



After applying this patch I get below errors with W=1 C=1

On 11/12/18 09:24, Biju Das wrote:
> +	if (unlikely(check_add_overflow(bytes, offset, &new_bytes)))
> +		return -EOVERFLOW;
>   drivers/nvmem/core.c:82:13: error: incompatible types in comparison 
expression (different type sizes)
drivers/nvmem/core.c:82:13: error: incompatible types in comparison 
expression (different type sizes)
drivers/nvmem/core.c:113:13: error: incompatible types in comparison 
expression (different type sizes)
drivers/nvmem/core.c:113:13: error: incompatible types in comparison 
expression (different type sizes)



--srini
