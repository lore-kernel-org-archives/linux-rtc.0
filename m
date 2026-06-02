Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611853BED27;
	Tue,  2 Jun 2026 08:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780389182; cv=none; b=n68tCrnuuHuNnE63/bdXqD6cKTm1sm1FiBQR/w14oyuurTAglmuOBrIyqb13p9mRdPezLiZb5pHvfv8smZBS/jJY2C9ctpqufs9zpo2i0XAtwC7VQtLwhCI2gXpaxcnwUJBaFvqoKpSuK8tVb86Lhxqu49VnCad+DZwC8ZNzdx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780389182; c=relaxed/simple;
	bh=NkSnbWGA31Jf8oKWMUYwDHeO9cVDLgLfCAsy8As5Si4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GQbX4CSstBi4lx5aB16P1EfUTxty3FWJIUU7nFgnp2t9s/DHxrV/oKnz8um20sVxjA37guw6wYNRIzzCM9msjVjxXJfo7STp4UeG3X0pJxH7EfTeB0ITSAsXy/JBp3xK8Yfb4hgmEpPC2XsXUqJpzEdfgLciojFpoam7iMuH8ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67071F00893;
	Tue,  2 Jun 2026 08:32:57 +0000 (UTC)
Message-ID: <d7206dfb-1642-4710-be8c-b43e0806ef95@tuxon.dev>
Date: Tue, 2 Jun 2026 11:32:56 +0300
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] rtc: renesas-rtca3: Factor out year decoding helper
To: Prabhakar <prabhakar.csengg@gmail.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-rtc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260506164914.3987293-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260506164914.3987293-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260506164914.3987293-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/6/26 19:49, Prabhakar wrote:
> From: Lad Prabhakar<prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> The logic to decode the year value from the hardware registers is
> duplicated in both rtca3_read_time() and rtca3_read_alarm().
> 
> Introduce a helper rtca3_decode_year() to centralize this conversion.
> 
> Signed-off-by: Lad Prabhakar<prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com> # on RZ/G3S
