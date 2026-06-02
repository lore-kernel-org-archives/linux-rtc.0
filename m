Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF09384CF6;
	Tue,  2 Jun 2026 08:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780389143; cv=none; b=gSH+lZfdpIfJlm+4PDL1GgOUamBR50UWduuRjM03vxJ4/6usASE35zKJTyvwMkMRLCrC8mh2gTruuyJrPmkrfeHbV+H5NRK1qs3B+vFUO1SHKebNwbgKQg3qWqYB+Hs3kmjeUS2ctY0IA/AJ/KCisU68hIP7Ev4bsW2czAV7oyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780389143; c=relaxed/simple;
	bh=TT7a+bd6FkjGR2DATEpanL8Y4xOA8aE/Llpr8DPa57o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fwIlFK+07p1NUbyZKEwQ3T4gU2/z06UFnFu29Lz7mfv7cln6BxWYXbusi7RL1/hQIFYAWKk2bc7A54pgUwU93/T7ElXFFHo9r5qilMujd3mXPkzd1XSY7aYBHU87eAJ9XkPm5ogFU1DmMwIzFWPyCWi4G3x2/02KQ9DgkWqt6FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A30D1F00893;
	Tue,  2 Jun 2026 08:32:18 +0000 (UTC)
Message-ID: <7f59b91d-cacc-4332-ac97-38e497816f65@tuxon.dev>
Date: Tue, 2 Jun 2026 11:32:16 +0300
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] rtc: renesas-rtca3: Check RADJ poll result during
 initial setup
To: Prabhakar <prabhakar.csengg@gmail.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-rtc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260506164914.3987293-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260506164914.3987293-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260506164914.3987293-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/6/26 19:49, Prabhakar wrote:
> From: Lad Prabhakar<prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> In rtca3_initial_setup(), the driver clears the RTCA3_RADJ register and
> waits for it to reach zero using readb_poll_timeout(). Check the return
> value of readb_poll_timeout() and propagate the error if the poll fails.
> 
> Signed-off-by: Lad Prabhakar<prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com> # on RZ/G3S
