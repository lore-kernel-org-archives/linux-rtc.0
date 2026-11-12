Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794468009;
	b=vwL7VmXvBLJf0LpVnFopiNFjelIdIQRQZiRNXCljOduOmJUPdo85athUySVVfmjs5lkq
	 cwfTA5CQnKt6D1ZYlzHAMx7TgyPMMxowpy2/oo7QQlJlcnD3nU26o+7Xngt06dnGG/pUF
	 jmfRqMGYwJCL+zS2hO/+vSjSpMdW4FRptdrDi+9BEMTlQNYH824yBE3yxEXddOpM5VB0Y
	 +BPO/rnz2I/gXutHoedVdm9jjIS7+vJBoMkMpG1See2ERM1ZxL0s+jp1ERwkTUImeHQaB
	 o8e0NHsxSh7YswDTUkLPVGPdL5d8iNN/Iv/xE7tF2JzZ7omrHvTveynR/XUjxAdjGtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794468009;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9/HjxlNorYVE0U9w2gtvfTOqdmZOBO9oQ5sC9b2Y3d0=;
	b=BjWjkn9V83s6cMCtZbh4qtMdDdpS4a9WJrWshQ/TBWtv0c0i5YZRwKZcG+aq9RJerGPo
	 1jjg0ON4KQlHcdoQJEgyCXnBjMMRfLAEmYP51il8/NrZX/YJA3uhxUWCe7iBfx5XzApDC
	 LTgLL+1weg3yFATNK6K2sF85FAfwQ3JDF9N32AfnyJRuLIc4wmy/0WusEEo3w1lB4x8V2
	 qM8c7adxBOwQeGL2C1QeWtiir43fdyz4QaEp8ZP5ABiw7p81t/c7hqPVxBXL/q8BNC+ZN
	 YCnTwG44+gEjnHZIhoqgxSlNDD7tg4IxyZIJAgr1RRCpGEr4qNikhZKMSJvUI0FjmnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lQG7GFfC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0DD606A321
	for <linux-rtc@vger.kernel.org>; Thu, 12 Nov 2026 07:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lQG7GFfC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A02E1F00A05;
	Thu, 12 Nov 2026 07:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794468009;
	bh=9/HjxlNorYVE0U9w2gtvfTOqdmZOBO9oQ5sC9b2Y3d0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lQG7GFfCeTzFTW3iL13wWyYTx4y0YmPHunzHhV24r6H8ERFtDbIKsQhh0D6U4dme1
	 5NS8BJOUM+0ovqQqcpnmJq11qd9SjidphbURAEpcyS5laDYID0YmDqHOVtAn0yOL0Q
	 N9M2indcOBFf2a/rh6JE5+4XnT8XH0QAIIyV05T5P/PmMMHQ3jpRIesQlq+JyNJ0wy
	 aRXe0PLS1fML+sI0cTF1SXdA+6wnjOGwAKuZ4vzvyb2LheojhzOK6vqL5+srfFRDCt
	 aIQOC92tcb8NnlTo1IU7niW+/5Wr2943LWnCPJTfKTBE3RYE1yfI/Tv8o1Br7ifVUK
	 8qri5pT+VTIvg==
Message-ID: <sashiko-outbox-210588@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: ac100: Program clock divider encodings without
 subtracting one
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhu Jun" <zhujun2@cmss.chinamobile.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261112071620.154398-1-zhujun2@cmss.chinamobile.com>
References: <20261112071620.154398-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 07:20:08 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> divider_get_val() already returns the hardware encoding for the
> power-of-two divider, and ac100_clkout_prediv[].val is also a register
> encoding. Subtracting one from either value programs the previous
> divider setting and turns encoding zero into all ones.
>=20
> For example, selecting a 32768 Hz output from the 32768 Hz parent
> programs divider seven and produces 256 Hz. Write both encodings
> directly so the programmed rate agrees with the requested rate.
>=20
> Fixes: 04940631b8d2 ("rtc: ac100: Add clk output support")
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112071620.1543=
98-1-zhujun2@cmss.chinamobile.com?part=3D1

