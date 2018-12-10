Return-Path: <SRS0=WBM2=OT=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D063CC04EB8
	for <linux-rtc@archiver.kernel.org>; Mon, 10 Dec 2018 12:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A9320821
	for <linux-rtc@archiver.kernel.org>; Mon, 10 Dec 2018 12:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HYkGDmpA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91A9320821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbeLJMhL (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 10 Dec 2018 07:37:11 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39448 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbeLJMhL (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 10 Dec 2018 07:37:11 -0500
Received: by mail-wm1-f68.google.com with SMTP id f81so11018568wmd.4
        for <linux-rtc@vger.kernel.org>; Mon, 10 Dec 2018 04:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+ujTHJwCVKXI813kSvxQiOtbaFGFRncXo1pg9K2gCSQ=;
        b=HYkGDmpA1izreCpk6vgF1CXwX8Yhg50Nr11VQPQkLIjf3BpCM2Q3LEKb1XoXcj7h+M
         mWspxubscj4evrPLRdM8ZLBIbvYnIMhI8h3jLfdun99BvVyuTdWKMXfuvzirtqYWGcqQ
         iqiAMF1S4rvlkwoRrl7XKYNbhTRXjpPnvCGw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+ujTHJwCVKXI813kSvxQiOtbaFGFRncXo1pg9K2gCSQ=;
        b=Tp7hbRXk3gc47eFWKJMm049x9A0WJrZimYQXda3byWAZUgzZvvuxbis1B5nmaAXh1m
         zKRY37gudNwrXDL+82SDMZg1H7X/dCOCUTuBXyhn63DmC0jeW+Cf0zWhy8ZWTaXFBH0W
         22y79+/y1sPv4FBOTpBAxdG52ElZ/iZ2GUaku97hSL8aZ/3bqVKpIC9rgthf5wJr4+UI
         ahXCqirylci9CPcJSuaRFyVGKujrAvCEQkcbP1tB7Gy4ELaofwfWF/GhJZZalbmab2AG
         K7mi5YBU/ndF9zhJ/NJaRWw7hmUiU3m3chMAa9qrnfJ9CX9HdHHrjmt7wEOPIteLsjJr
         oHkw==
X-Gm-Message-State: AA+aEWYqGlUL3EFQ2eIzM1W7E9k4XjJXm9mr4jkPqwI1irQpIYd42Sk9
        6v2gDA5aRCRRMfzkgZlNNvYnwQ==
X-Google-Smtp-Source: AFSGD/WdlpCHXKMXDOl+FD4PDwCKVzMUhFuuxG9oJU2TzcGRDCKkhRtKu22ZIianzS7Fe6LXpkGBRA==
X-Received: by 2002:a1c:5585:: with SMTP id j127-v6mr9715402wmb.127.1544445428285;
        Mon, 10 Dec 2018 04:37:08 -0800 (PST)
Received: from [192.168.86.29] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id h16sm33313910wrb.62.2018.12.10.04.37.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 04:37:07 -0800 (PST)
Subject: Re: [PATCH v4 1/5] nvmem: check invalid number of bytes in
 nvmem_device_{read,write}
To:     Biju Das <biju.das@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Simon Horman <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <1544182066-31528-1-git-send-email-biju.das@bp.renesas.com>
 <1544182066-31528-2-git-send-email-biju.das@bp.renesas.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <3c09d148-7102-1ee5-770a-009e40de6168@linaro.org>
Date:   Mon, 10 Dec 2018 12:37:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1544182066-31528-2-git-send-email-biju.das@bp.renesas.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Thanks for the patch.

On 07/12/18 11:27, Biju Das wrote:
> Add check in nvmem_device_{read,write}()to ensure that nvmem core never
> passes an invalid number of bytes.
> 
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> ---
> V3-->V4
> 	* New patch.
> ---
>   drivers/nvmem/core.c | 26 +++++++++++++++++++++++++-
>   1 file changed, 25 insertions(+), 1 deletion(-)
> 

Its better to move checks from 
bin_attr_nvmem_read()/bin_attr_nvmem_write() into nvmem_reg_read() and 
nvmem_reg_write(), so its easy to maintain, rather than adding them to 
each function.

> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index d9fd110..db7de33 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -1433,10 +1433,21 @@ int nvmem_device_read(struct nvmem_device *nvmem,
>   		      size_t bytes, void *buf)
>   {
>   	int rc;
> +	size_t new_bytes;
>   
>   	if (!nvmem)
>   		return -EINVAL;
>   
> +	/* Stop the user from reading */
> +	if ((offset >= nvmem->size) || (bytes == 0))
> +		return 0;
> +
> +	if (unlikely(check_add_overflow(bytes, offset, &new_bytes)))
> +		return -EOVERFLOW;
> +
> +	if (new_bytes > nvmem->size)
> +		bytes = nvmem->size - offset;
> +
>   	rc = nvmem_reg_read(nvmem, offset, buf, bytes);
>   
>   	if (rc)
> @@ -1461,16 +1472,29 @@ int nvmem_device_write(struct nvmem_device *nvmem,
>   		       size_t bytes, void *buf)
>   {
>   	int rc;
> +	size_t new_bytes;
>   
>   	if (!nvmem)
>   		return -EINVAL;
>   
> +	/* Stop the user from writing */
> +	if (offset >= nvmem->size)
> +		return -ENOSPC;
> +
> +	if (bytes == 0)
> +		return 0;
> +
> +	if (unlikely(check_add_overflow(bytes, offset, &new_bytes)))
> +		return -EOVERFLOW;
> +
> +	if (new_bytes > nvmem->size)
> +		bytes = nvmem->size - offset;
> +
>   	rc = nvmem_reg_write(nvmem, offset, buf, bytes);
>   
>   	if (rc)
>   		return rc;
>   
> -

Unrelated change!


--srini
>   	return bytes;
>   }
>   EXPORT_SYMBOL_GPL(nvmem_device_write);
> 
