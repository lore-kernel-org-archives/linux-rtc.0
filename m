Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5903421CC71
	for <linux-rtc@vger.kernel.org>; Sun, 12 Apr 2026 21:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776029624; cv=none; b=gS5Vimy/qG1kIzLJxpZ/pXUWWdWl0CoVCHqdTT+FNCC52U/NF+iuJkS2sYCN+tCFDf/zQ5t2CVg5Zr7WXOsquJ/E93f2cf4J/tGXEoUba3XEWGFepUQtkBFYpXxw15wxSMPqQWlMODGdjrbQonoGxlug5cwGaLGDrQjNZoMAP9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776029624; c=relaxed/simple;
	bh=ZzIwF7214SgJR1XnNi4CdWXSPdhix5rjiZgI14EmxaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2gUZpy1Q44tu4q6Xty4LgMMOp93QrdU/oOytAwu6EAmllfqLQI/0GNnXMQtk95v06wtb1C+DwkIUV2zGmd3Fi0V5nWq/5E4u/F8ozsSFYYDIAc2wtXgheYBKcAOSEG0eHo+/wJnDe0em0sIejqkVFIcysr/3ff5RhLSrkZEZtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=z8yObDqz; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="z8yObDqz"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B78D61A31FA
	for <linux-rtc@vger.kernel.org>; Sun, 12 Apr 2026 21:33:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7F72D5FFB9;
	Sun, 12 Apr 2026 21:33:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7302810450096;
	Sun, 12 Apr 2026 23:33:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776029619; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=5PqYR6xlDIDLi8ZseU9XqgCwMIe/++hpnKNHOm09TgI=;
	b=z8yObDqzoDkvhOTW4plkc19FbhID/nkZdyDwJgukOjpZ+xZZwzCrz+7r71DRTr9UziLgtg
	pXgwiNBXWylLzWiuoEXyuOjFOtkd7ic/ppq8MXF7I5ftyxus/fkNCOK6WyASic/osZ36YF
	kahP4x1GJuFxCBxLs3EsAh+GJZlFb8mqCG0weO1T1bY982MGoRM0en2/4a3xuVWzocOzTv
	BBPV3JbUAGKq2ZomgenvQKJUWVIWIeeHVMIUYPxDOnhiYUIYSIz1UqsdmCCrulwMhj/bVK
	e/eL3tBQsXz3neiTlo35wOWLOR6f7dnG98FUu5ibCGPYpJRgf97loTJh7jDRtA==
Date: Sun, 12 Apr 2026 23:33:36 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Zhaoyang Yu <2426767509@qq.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: spear: check return value of clk_enable in resume
Message-ID: <20260412213336c5c1e339@mail.local>
References: <tencent_6BA6C87DB3B5EE61C7A22CADE9F5DBBCC90A@qq.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_6BA6C87DB3B5EE61C7A22CADE9F5DBBCC90A@qq.com>
X-Last-TLS-Session-Version: TLSv1.3

On 01/03/2026 16:19:58+0000, Zhaoyang Yu wrote:
> In spear_rtc_resume(), the return value of clk_enable() is currently
> ignored. If clk_enable() fails, the driver proceeds to call
> spear_rtc_enable_interrupt().
> 
> The spear_rtc_enable_interrupt() function performs a readl() on the
> RTC control register (CTRL_REG) as its first operation. Accessing an
> MMIO register of a peripheral without an enabled functional clock is
> unsafe on SPEAr architectures and can lead to a system hang or data
> abort.
> 
> Fix this by checking the return value of clk_enable(). If it fails,
> print an error message and return the error code to avoid the unsafe
> register access.
> 
> Signed-off-by: Zhaoyang Yu <2426767509@qq.com>
> ---
>  drivers/rtc/rtc-spear.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-spear.c b/drivers/rtc/rtc-spear.c
> index 959acff8faff..9bf7cf264715 100644
> --- a/drivers/rtc/rtc-spear.c
> +++ b/drivers/rtc/rtc-spear.c
> @@ -437,7 +437,7 @@ static int spear_rtc_resume(struct device *dev)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct spear_rtc_config *config = platform_get_drvdata(pdev);
> -	int irq;
> +	int irq, ret;
>  
>  	irq = platform_get_irq(pdev, 0);
>  
> @@ -447,7 +447,11 @@ static int spear_rtc_resume(struct device *dev)
>  			config->irq_wake = 0;
>  		}
>  	} else {
> -		clk_enable(config->clk);

On spear, this function will never fail as this ultimately calls static
void clk_gate_endisable.

> +		ret = clk_enable(config->clk);
> +		if (ret) {
> +			dev_err(dev, "Unable to enable clock on resume: %d\n", ret);
> +			return ret;
> +		}
>  		spear_rtc_enable_interrupt(config);
>  	}
>  
> -- 
> 2.34.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
