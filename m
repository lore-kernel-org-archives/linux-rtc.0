Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CCCC4332F
	for <linux-rtc@archiver.kernel.org>; Thu,  5 May 2022 14:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380896AbiEEO7K (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 5 May 2022 10:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380862AbiEEO7F (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 5 May 2022 10:59:05 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84DC15A0D;
        Thu,  5 May 2022 07:55:19 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id A139B1F4588E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651762518;
        bh=GSjTTKSKlxp6CGEr4r1uWboFqF4OcgikJc5WH+aZ4/g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SJeHf6jcioipzxnqvWHiLnb/Q1GKNNe7Torc+t3v+XGkNPVGer0XJqqww15x5s7++
         JFVRgNpIP+Uc6vgIjALYu2ncBzZ3/LQXXxXNG9/ExD/YJf0JsfQREX7Hr1X+dIbBX/
         hxuX9tcfhgKIRXdimnMVnWVT/TV9CUqZYzyX/OyUYtJHMGIMlPOHd8cgraOuI6zkut
         pkfBIvN+sFxwp0xQni6t3OwL9IsKrdKDDtqizkhc4iwPy+aFTn7X7gnL80sftX4T/o
         7wLjXssOAYv+zaDjFBuhexxy2v6rKxBgxVgu9OkgHvyWsepWCdH3Y18RcMkpajzI4c
         56GWuJLcMAA+w==
Message-ID: <977dc0eb-fb3e-85bb-43a1-929da9aef307@collabora.com>
Date:   Thu, 5 May 2022 16:55:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] rtc: mt6397: check return value after calling
 platform_get_resource()
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     eddie.huang@mediatek.com, sean.wang@mediatek.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        lee.jones@linaro.org
References: <20220505125043.1594771-1-yangyingliang@huawei.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220505125043.1594771-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Il 05/05/22 14:50, Yang Yingliang ha scritto:
> It will cause null-ptr-deref if platform_get_resource() returns NULL,
> we need check the return value.
> 
> Fixes: fc2979118f3f ("rtc: mediatek: Add MT6397 RTC driver")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
