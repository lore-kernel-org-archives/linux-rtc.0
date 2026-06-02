Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BD537CD20;
	Tue,  2 Jun 2026 08:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780389117; cv=none; b=HJgH5iK/YVEwiGjgxApEWVL1ThsVMbbzadAmEfF3TCLn8IpjnRZMfC7EuyoFPkfZf2A4gOpxhLsxvQz+nTWVHsFM1QCwwTOWCXy5nq/NNgixAI/UG2Gd202iWg4Jagwkore9ShD0QjNX8jyAfIiThJLNNsQTW1O6WxLTSVpRgWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780389117; c=relaxed/simple;
	bh=ChGlVjhD1oeKnMqlYdNzx2F1AJ6mT3VcM1r2RVhbJDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CJLJXDazFJ3WMxjwDLmX9xiegwLcJKovGvkKzSinQJrCDobEtGmGlFngZpkObCSn5cFLhVGF4hhd1lOIn1C427GCrkYh28NkzE6KxvM2Rd3NJxkRgDJu7pyWNXAaPIemexhUxGCbQTSOwuJEm/kmOTxpkU8CD7XFRIFGvP3HTd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC241F00893;
	Tue,  2 Jun 2026 08:31:52 +0000 (UTC)
Message-ID: <7f6fe294-582d-4668-aa77-ad9ab47cce2e@tuxon.dev>
Date: Tue, 2 Jun 2026 11:31:51 +0300
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] rtc: renesas-rtca3: Fix PIE clear polling condition
 in alarm setup error path
To: Prabhakar <prabhakar.csengg@gmail.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-rtc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260506164914.3987293-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260506164914.3987293-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260506164914.3987293-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Prabhakar,

On 5/6/26 19:49, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> In rtca3_set_alarm(), the setup_failed path attempts to disable the
> Periodic Interrupt Enable (PIE) bit and wait until it is cleared.
> However, the polling condition passed to readb_poll_timeout_atomic()
> uses an incorrect expression:
> 
>      !(tmp & ~RTCA3_RCR1_PIE)
> 
> As ~RTCA3_RCR1_PIE evaluates to a mask of all bits except PIE, the
> condition effectively waits for all non-PIE bits to become zero, which
> is unrelated to the intended operation and is unlikely to ever be true.
> This causes the poll to time out unnecessarily.
> 
> Fix the condition to check for the PIE bit itself being cleared:
> 
>      !(tmp & RTCA3_RCR1_PIE)
> 
> This correctly waits until PIE is deasserted after being cleared.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com> # on RZ/G3S

I think it also deserves a Fixes tag?

Thank you,
Claudiu
