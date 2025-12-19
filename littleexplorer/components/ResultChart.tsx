import React, { useEffect, useRef } from 'react';
import * as d3 from 'd3';

interface ResultChartProps {
  score: number; // 0 to 100 normalized score
  label: string;
  lowLabel: string;
  highLabel: string;
  description: string;
}

export const ResultChart: React.FC<ResultChartProps> = ({ 
  score, 
  label, 
  lowLabel, 
  highLabel,
  description
}) => {
  const svgRef = useRef<SVGSVGElement>(null);

  useEffect(() => {
    if (!svgRef.current) return;

    const svg = d3.select(svgRef.current);
    svg.selectAll("*").remove(); // Clear previous

    const width = svgRef.current.clientWidth;
    const height = 120;
    const margin = { top: 40, right: 30, bottom: 40, left: 30 };
    const chartWidth = width - margin.left - margin.right;

    // Gradient definition
    const defs = svg.append("defs");
    const gradient = defs.append("linearGradient")
      .attr("id", "rangeGradient")
      .attr("x1", "0%")
      .attr("x2", "100%")
      .attr("y1", "0%")
      .attr("y2", "0%");

    gradient.append("stop").attr("offset", "0%").attr("stop-color", "#fbbf24"); // Yellow
    gradient.append("stop").attr("offset", "50%").attr("stop-color", "#4ade80"); // Green
    gradient.append("stop").attr("offset", "100%").attr("stop-color", "#60a5fa"); // Blue

    const g = svg.append("g")
      .attr("transform", `translate(${margin.left},${margin.top})`);

    // Draw the "Typical Range" bar
    g.append("rect")
      .attr("x", 0)
      .attr("y", 10)
      .attr("width", chartWidth)
      .attr("height", 20)
      .attr("rx", 10)
      .attr("fill", "url(#rangeGradient)")
      .attr("opacity", 0.3);

    // Draw the scale line
    g.append("line")
      .attr("x1", 0)
      .attr("y1", 20)
      .attr("x2", chartWidth)
      .attr("y2", 20)
      .attr("stroke", "#94a3b8")
      .attr("stroke-width", 2)
      .attr("stroke-dasharray", "4 4");

    // Indicator Dot (Child's Position)
    // Clamp score between 5 and 95 for visual padding
    const clampedScore = Math.max(5, Math.min(95, score));
    const cx = (clampedScore / 100) * chartWidth;

    g.append("circle")
      .attr("cx", cx)
      .attr("cy", 20)
      .attr("r", 8)
      .attr("fill", "#2563eb")
      .attr("stroke", "#fff")
      .attr("stroke-width", 2);

    // Indicator Label
    g.append("text")
      .attr("x", cx)
      .attr("y", -10)
      .attr("text-anchor", "middle")
      .attr("font-size", "14px")
      .attr("font-weight", "bold")
      .attr("fill", "#1e40af")
      .text("Your Child");

    // Range Labels
    g.append("text")
      .attr("x", 0)
      .attr("y", 50)
      .attr("text-anchor", "start")
      .attr("font-size", "12px")
      .attr("fill", "#64748b")
      .text(lowLabel);

    g.append("text")
      .attr("x", chartWidth)
      .attr("y", 50)
      .attr("text-anchor", "end")
      .attr("font-size", "12px")
      .attr("fill", "#64748b")
      .text(highLabel);

  }, [score, lowLabel, highLabel]);

  return (
    <div className="bg-white p-4 rounded-xl shadow-sm border border-slate-100 mb-4">
      <h3 className="text-lg font-bold text-slate-800 mb-1">{label}</h3>
      <p className="text-sm text-slate-500 mb-2">{description}</p>
      <svg ref={svgRef} className="w-full h-[120px]" />
    </div>
  );
};
