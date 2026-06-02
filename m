Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF1B3BED27;
	Tue,  2 Jun 2026 08:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780389169; cv=none; b=jsKadxZDj5TMliOPuUDx7GKjNzvJsxXpjzia4qAzxeo27DzkOL4BC0FgW5YnxmZ/tta/RT3ZolZgXXR5mLwGJjmBcuZdrKLP3QUbQxlyVAE4TB8OUtSduxoePlWBVWVB0LqqPzi3+oIdULTnRam5pnPL82PCXit0gZEh/IB0npY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780389169; c=relaxed/simple;
	bh=qqNCKMAaLr1HTwbzbmS2abAsUQROgPJ8wtz5nvzKm1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AbHkfvjyHOJkYI3BVggxYwIS3jbVsfr97oGKw0KAEaxVbXfP7v3iDjdr+mQokHGGTlvqMUWt4LknuhRvMy44DkCO6Gn55j4AKGFYxAZX7GdmugexKKeJWuV8A5++RDDFAwbhuYi8LERPOeHT18IYdp1T+6xL6vP8KwYqslfcVNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E2D1F00893;
	Tue,  2 Jun 2026 08:32:45 +0000 (UTC)
Message-ID: <6f5be8ea-f89a-496d-a285-11a7cd3e42c7@tuxon.dev>
Date: Tue, 2 Jun 2026 11:32:44 +0300
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] rtc: renesas-rtca3: Fix typo in rtca3_ppb_per_cycle
 documentation
To: Prabhakar <prabhakar.csengg@gmail.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-rtc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260506164914.3987293-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260506164914.3987293-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260506164914.3987293-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/6/26 19:49, Prabhakar wrote:
> From: Lad Prabhakar<prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Correct a typo in the kernel-doc comment for struct
> rtca3_ppb_per_cycle by fixing "adjutment" to "adjustment".
> 
> Signed-off-by: Lad Prabhakar<prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com> # on RZ/G3S
